Rails.application.routes.draw do
  devise_for :users
  root "restaurants#index"
  
  resources :restaurants
end
