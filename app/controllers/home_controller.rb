class HomeController < ApplicationController
  before_action :authenticate_user!, :new_init

  def index
    #add pagination
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
    render "index"
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
    render "index"
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
