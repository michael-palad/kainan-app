Rails.application.routes.draw do
  devise_for :users
  root "restaurants#index"
  
  resources :restaurants do
    member do
      patch "star-restaurant", to: "restaurants#give_star", as: "star"
      delete "unstar-restaurant", to: "restaurants#remove_star", as: "unstar"
    end
    
    collection do
      get "give-me-3", to: "restaurants#give_me_3", as: "give_me_3"  
    end
  end
end
