Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get "signup", to: "users/registrations#new"
    get "login", to: "users/sessions#new"
    get "logout", to: "users/sessions#destroy"
    get 'users', to: redirect('/users/sign_up')
  end

  resources :users, only: %i[show]
  resources :posts, only: %i[create]
  root "posts#index"
end
