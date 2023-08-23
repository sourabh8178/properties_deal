Rails.application.routes.draw do
  get 'feeedbacks/_feedback'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"
  get "show", to: "home#show"
  get "grad", to: "home#grad"
  get "property/:id", to: "home#show"
  get "view_all_property", to: "home#view_all_property"
  resources :rooms do
    resources :messages
  end
  get "message", to: "home#message"
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
