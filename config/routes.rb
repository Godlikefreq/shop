Rails.application.routes.draw do
  root to: "products#index"
  resources :products
  post "checkout/create", to: "checkout#create"
end
