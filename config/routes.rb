Rails.application.routes.draw do
  devise_for :users
  root to: "products#index"
  resources :products
  post "checkout/create", to: "checkout#create"
  resources :webhooks, only: %i[ create ]
  get "success", to: "checkout#success"
  get "cancel", to: "checkout#cancel"
end
