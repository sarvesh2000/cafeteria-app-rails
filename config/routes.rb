Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#home"
  resources :items
  get "signup", to: "users#new"
  resources :users, except: [:new]
  get "customerSignup", to: "customers#new"
  resources :customers, except: [:new]
  get "signin", to: "sessions#new"
  post "signin", to: "sessions#create"
  get "customerSignin", to: "sessions#newCustomer"
  post "customerSignin", to: "sessions#createCustomer"
  delete "logout", to: "sessions#destroy"
end
