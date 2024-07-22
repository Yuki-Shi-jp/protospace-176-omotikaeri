Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  resources :comments do
    resources :comments, only: :create
  end
  resources :prototypes
end
