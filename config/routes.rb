Rails.application.routes.draw do
  devise_for :users
  root "restaurants#index"
  
  resources :restaurants do
    member do
      patch "star-restaurant", to: "restaurants#give_star", as: "star"
      delete "unstar-restaurant", to: "restaurants#remove_star", as: "unstar"
    end
  end
end
