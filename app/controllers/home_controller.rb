class HomeController < ApplicationController
  before_action :authenticate_user!, :new_init

  def index
    #add pagination
    @active = "home"
  end

  def check_out
    b = Book.find(params[:id])
    #Add record to library
    if b.library != nil
      r = Record.where(book_id: b.id, library_id: b.library.id).first_or_create
      if r.num_rentals.nil?
        r.num_rentals = 1
      else
        r.num_rentals += 1
      end
      #Save Record
      r.save

      #Remove Library from Book
      b.library = nil

      #Add Book to User
      b.user = current_user
      b.save
    end
    redirect_to root_path
  end

  def check_in
    b = Book.find(params[:id])

    if b.user != nil

      #Remove User from Book
      b.user = nil

      #Add Book to Library
      l = Library.find(params[:library_id])
      b.library = l
      b.save
    end
    redirect_to root_path
  end

  def search
    @users = User.all
    @filterrific = initialize_filterrific(
        Book,
        params[:filterrific],
        select_options: {
            sorted_by: Book.options_for_sorted_by,
            with_library_id: Library.options_for_select,
            with_user_id: User.options_for_select
        },
    ) or return
    @books = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def transfer_to_library
    b = Book.find(params[:id])

    b.user = nil

    b.library = Library.find(params[:library_id])

    b.save
    redirect_to search_path
  end

  def transfer_to_user
    b = Book.find(params[:id])

    b.library = nil

    b.user = User.find(params[:user_id])

    b.save
    redirect_to search_path
  end

  private
  def new_init
    @lib = Library.new
    @book = Book.new
    @libraries = Library.all
    @user_inv = Book.where(:user_id => current_user.id)
  end
  def library_params
    params.require(:library).permit(:name)
  end
end
