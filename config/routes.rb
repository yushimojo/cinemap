Rails.application.routes.draw do
 
    # 顧客用
  # URL /customers/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  devise_scope :user do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  
  root to: "public/homes#top"
  # 会員用
  namespace :public do
    resources :movies do
      resources :movie_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end 
  
    resources :users, only: [:show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get :followings, on: :member
      get :followers, on: :member
    end 
  end
    
  # 管理者用
  namespace :admin do
    root to: "homes#top"
    resources :users, only: [:index, :show, :destroy]
  end
  
end 
