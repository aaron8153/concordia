class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update, :destroy]

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
    if @book.update(book_params)
      redirect_to controller: "home", action:"index", notice: 'Book was successfully updated.'
    end
  end

  # DELETE /Books/1
  # DELETE /Books/1.json
  def destroy
    @book.destroy
    redirect_to controller: "home", action:"index", notice: 'Book was successfully destroyed.'
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
