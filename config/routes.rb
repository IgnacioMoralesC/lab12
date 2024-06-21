Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "posts#index", as: :authenticated_root
  end

  root to: redirect('/users/sign_in')

  get 'guest', to: 'guest_sessions#create', as: 'guest'

  resources :posts do
    resources :comments, only: [:new, :create]
  end

  resources :comments

  resources :users, only: [:show]
end

