Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # Home Page Route
  root "pages#home"

  # Items Routes
  resources :items

  # Cart Routes
  post "/items/cart/:id", to: "items#addToCart", as: "add_to_cart"
  delete "/items/cart/remove/:id", to: "items#removeFromCart", as: "remove_from_cart"
  
  # Cafeteria User Routes
  get "signup", to: "users#new"
  get "signin", to: "sessions#new"
  post "signin", to: "sessions#create"
  resources :users, except: [:new]
  get "/users/orders/view/pending", to: "users#viewPendingOrders", as: "view_pending_orders"
  get "/users/orders/view/completed", to: "users#viewCompletedOrders", as: "view_completed_orders"
  post "orders/complete/:id", to: "users#completeOrder", as: "complete_order"
  
  # Customer Routes
  get "customerSignup", to: "customers#new"
  resources :customers, except: [:new, :show]
  get "customerSignin", to: "sessions#newCustomer"
  post "customerSignin", to: "sessions#createCustomer"
  get "customers/:cafeteria_id/cafeteria", to: "customers#viewCafeteria", as: "cafeteria_profile"
  get "customers/orders", to: "customers#orderHistory", as: "customer_order_history"
  post "checkout", to: "customers#checkout", as: "checkout"


  # Owner Routes
  resources :owners
  get "ownerSignin", to: "sessions#newOwner"
  post "ownerSignin", to: "sessions#createOwner"
  get "owner/orders", to: "owners#viewOrders", as: "owner_view_orders"
  get "owner/users", to: "owners#viewUsers", as: "owner_view_users"

  # Auth Routes
  delete "logout", to: "sessions#destroy"
end
