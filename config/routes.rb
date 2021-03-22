Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items
  get "signup", to: "users#new"
  resources :users, except: [:new]
  get "signin", to: "sessions#new"
  post "signin", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
