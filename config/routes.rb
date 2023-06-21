Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "home#index"

  get "dashboard", to: "pages#dashboard", as: :dashboard
  get "learning", to: "pages#learning", as: :learning
  get "invoices", to: "invoices#index"
  get "projects", to: "projects#index"
  get "clients", to: "clients#index"

  get "invoices/:id/update_invoice_status", to: "invoices#update_invoice_status", as: :update_status

  resources :projects, only: [:index, :show] do
    resources :tasks, only: [:new, :create]
    resources :invoices, only: [:new, :create, :show]
  end

  resources :tasks, only: [:show, :create, :update]
  resources :invoices, only: [:show]

  resources :clients do
    resources :projects, only: [:new, :create]
  end

  resources :invoices, only: [:update]

end
