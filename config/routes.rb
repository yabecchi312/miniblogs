Rails.application.routes.draw do
  devise_for :users
  root to: "products#index"
  resources :products, only: [:index, :show, :new, :create, :destroy, :edit, :update]
  resources :users, only: [:show]
end
