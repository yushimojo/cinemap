class Public::UsersController < ApplicationController
     before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
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
    
     def ensure_guest_user
    @user = User.find(params[:id])
    if @user.nickname == "ゲストユーザー"
      redirect_to public_user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
    
    
    private

   def user_params
    params.require(:user).permit(:nickname, :profile_image, :introduction, :gender, :age, :user_id)
   end 

   
end
