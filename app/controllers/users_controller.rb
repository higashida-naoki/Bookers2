class UsersController < ApplicationController

    def show
      @user = User.find(params[:id])
      @books = @user.books
      @book = Book.new 
    end
  
    def edit
      @user = User.find(params[:id])
      unless @user.id == current_user.id
        redirect_to user_path(current_user)
      end
      @book = Book.new
    end

    def index
      @users = User.all
      @user = current_user
      @books = @user.books
      @book = Book.new
    end

    def update
      @user = User.find(params[:id])
      
      unless @user.id == current_user.id
        redirect_to user_path(current_user)
      end
      #@user = User.find(params[:id])
      if @user.update(user_params)
         flash[:notice] = "You have updated user successfully."
         redirect_to user_path(@user.id)
      else
        @book = Book.new
        render :edit
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end
  
    def is_matching_login_user
      user = User.find(params[:id])
      unless user.id == current_user.id
        redirect_to books_path
      end
    end

end
