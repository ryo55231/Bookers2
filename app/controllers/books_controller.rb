class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "You have created book successfully."

    redirect_to books_path
    else
    @books = Book.all
    render :show
    end
  end

  def index
  @books = Book.all

  @user = current_user
  end

  def show
  @book = Book.find(params[:id])
  @user = User.find(params[:id])
  end

  def edit
  @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book.id)
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end
  private

  def book_params
params.require(:book).permit(:title, :body, )
  end
end