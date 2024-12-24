class BooksController < ApplicationController

  def new
    @Book = Book.new
  end

  # 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to books_path
  end

  def index
    @books = Book.page(params[:page])
    @user = current_user
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @books = @user.books
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy 
    redirect_to '/books'
  end
  
  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end

end
