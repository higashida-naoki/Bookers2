class BooksController < ApplicationController

  def new
    @Book = Book.new
  end

  # 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @books = Book.page(params[:page])
    @user = current_user
    @book = Book.new

  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
    @user = @book.user
    
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @books = @user.books
  end

  def update
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
    if @book.update(book_params)
      flash[:notice] = "Book was successfully created"
      redirect_to book_path(@book.id)
    else
       flash[:notice]
      render :edit
    end
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
