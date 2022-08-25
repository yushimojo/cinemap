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
  
 
  
  root to: "public/homes#top"
  # 会員用
  namespace :public do
    resources :movies do
    resources :movie_comments, only: [:create, :destroy]
  end 
    resources :users, only: [:show, :edit, :update, :destroy]
    resource :favorites, only: [:create, :destroy]
    get "search" => "searches#search"
      
  end
    
  # 管理者用
  namespace :admin do
    root to: "homes#top"
      
  end
    
end 
