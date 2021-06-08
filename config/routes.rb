Rails.application.routes.draw do
 
  devise_for :users
  root to: 'homes#top'
  get "home/about" => 'homes#about'
  
   resources :books do
   resource :favorites, only: [:create, :destroy]
   
   resources :post_comments, only: [:create, :destroy]
  end
  
   resources :users,only: [:show,:index,:edit,:update] do
   
   resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
 end
 
 get "search" => 'searchs#search'
 end