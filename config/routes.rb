Rails.application.routes.draw do

  devise_for :users
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
     get 'home/about', to: 'homes#about'
  resources :books, only: [:new, :create, :index,  :destroy, :show, :edit, :update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update,  :destroy]
end
