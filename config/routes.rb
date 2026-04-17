Rails.application.routes.draw do
  resources :sales
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  root "products#index"
  resources :products
  get "purchase", to: "products#purchase"
  get "confirmPurchase/:id", to: "products#confirmPurchase", as: :confirmPurchase

  get "cart/index"
  get "cart", to: "carts#index", as: :cart
  post "cart/add", to: "carts#add", as: :add_to_cart
  delete "cart/remove", to: "carts#remove", as: :cart_remove
  post "cart/clear", to: "carts#clear", as: :cart_clear
  get "cart/receipt/:id", to: "carts#receipt", as: :cart_receipt
  patch "cart/update", to: "carts#update", as: :cart_update




  # post "confirmPurchase/:id", to: "products#confirmPurchase", as: :confirmPurchase



  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
