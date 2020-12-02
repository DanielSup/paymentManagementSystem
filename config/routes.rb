Rails.application.routes.draw do
  get 'users/index'
  resources :payments
  devise_for :users
  get '', to: 'payments#index'
  resources :users, only: [:index]
  patch 'users/:id/deactivate', to: 'users#deactivate', as: 'user'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
