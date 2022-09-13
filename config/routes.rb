Rails.application.routes.draw do
  resources :posts, only: %i[index, create]
  root "post#index"
end
