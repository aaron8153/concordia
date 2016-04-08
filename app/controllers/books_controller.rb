class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /Books
  # GET /Books.json
  def index
    @books = Book.all
  end

  # GET /Books/1
  # GET /Books/1.json
  def show
  end

  # GET /Books/new
  def new
    @book = Book.new
  end

  # GET /Books/1/edit
  def edit
  end

  # POST /Books
  # POST /Books.json
  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      redirect_to controller: "home", action:"index", notice: 'Book was successfully created.'
    end

  end

  # PATCH/PUT /Books/1
  # PATCH/PUT /Books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Books/1
  # DELETE /Books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to Books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:name, :isbn)
    end
end