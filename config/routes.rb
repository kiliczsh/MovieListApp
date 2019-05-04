Rails.application.routes.draw do
  resources :watchlists
  resources :searches

  root to: 'searches#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
