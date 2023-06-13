Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "home#index"

  get "dashboard", to: "pages#dashboard"

  resources :projects, only: [:index, :new, :create, :show]
  resources :tasks, only: [:show]
  resources :invoices, only: [:show]

end
