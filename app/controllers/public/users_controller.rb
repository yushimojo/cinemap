class Public::UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @movies = @user.movies 
    end
    
    def edit
    end
end
