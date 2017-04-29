Rails.application.routes.draw do
  devise_for :users
  root 'restaurants#index'
  
  resources :restaurants do
    member do
      patch 'star-restaurant', to: 'restaurants#give_star', as: 'star'
      delete 'unstar-restaurant', to: 'restaurants#remove_star', as: 'unstar'
    end
    
    collection do
      get 'random', to: 'restaurants#random', as: 'random'  
      get 'cuisine/:name', to: 'restaurants#cuisine_filter', as: 'cuisine'
      get 'most-popular', to: 'restaurants#most_popular', as: 'most_popular'
      get 'starred', to: 'restaurants#starred_filter', as: 'starred'
    end
  end
end
