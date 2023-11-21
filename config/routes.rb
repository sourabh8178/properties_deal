Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :payments
  root "home#index"
  get "show", to: "home#show"
  get "grad", to: "home#grad"
  get "property/:id", to: "home#show"
  get "/profile", to: "home#profile"
  patch "profile", to: "home#update_profile"
  post "profile", to: "home#create_profile", as: "profile_user"
  get "profile_about", to: "home#profile_about"
  get "security", to: "home#security"
  post "/password_change", to: "home#password_change"
  get "view_all_property", to: "home#view_all_property"
  post "/create-checkout-session", to: "payments#checkout"
  get "/success", to: "payments#success"
  post "/contact", to: "contacts#create"
  get "/plans", to: "payments#plans"
  post "/subscription", to: "payments#subscription"
  get "/loader", to: "payments#loader_payment"
  get "/place_order/:id", to: "payments#place_order"
  get "/order/:id", to: "payments#order_view"
  get "/refund", to: "payment#refund"
  get "/notif_read/:id", to: "notifications#notif_read"
  get "/marked_as_read", to: "notifications#marked_as_read"
  resources :rooms do
    resources :messages
  end
  # get "message", to: "home#message"
  get "/user_chat", to: "rooms#user_chat"
  get "feedbacks", to: "feedbacks#create"
  resources :properties do
    resources :feedbacks
  end

  namespace :admin do
    root "dashboard#index"
    resources :companies
    resources :users
    resources :properties
    resources :profiles
    # get "properties", to: "properties#index"    
  end
end
