class Public::UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @movies = @user.movies 
    end
    
    def edit
        @user=User.find(params[:id])
    end
    
    def update
        @user = current_user
    #@user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to public_user_path
    else
      render :edit
    end
    end
    
    private

   def user_params
    params.require(:user).permit(:nickname, :profile_image, :introduction, :gender, :age, :user_id)
   end 

   
end
