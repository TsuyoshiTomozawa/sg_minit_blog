Rails.application.routes.draw do
  resources :posts, only: %i[create]
  root "posts#index"
end
