class UsersController < ApplicationController

    def show
      @user = User.find(params[:id])
      @users = @user.books    
    end
  
    def edit
      @user = User.find(params[:id])
    end

end
