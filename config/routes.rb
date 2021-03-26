Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#home"
  resources :items
  post "/items/cart/:id", to: "items#addToCart", as: "add_to_cart"
  delete "/items/cart/remove/:id", to: "items#removeFromCart", as: "remove_from_cart"
  get "signup", to: "users#new"
  resources :users, except: [:new]
  get "customerSignup", to: "customers#new"
  resources :customers, except: [:new]
  get "signin", to: "sessions#new"
  post "signin", to: "sessions#create"
  get "customerSignin", to: "sessions#newCustomer"
  post "customerSignin", to: "sessions#createCustomer"
  resources :owners
  get "ownerSignin", to: "sessions#newOwner"
  post "ownerSignin", to: "sessions#createOwner"
  delete "logout", to: "sessions#destroy"
end
