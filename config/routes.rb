Rails.application.routes.draw do
  root to: 'orders#index'

  namespace :api do
    resources :orders, only: [:index, :create, :update], defaults: { format: :json }
  end

  resources :orders, only: [:index]
end
