Rails.application.routes.draw do
  resources :meetings
  resources :posts
  resources :properties
  devise_for :accounts

  get "/blog" => "posts#latest", as: :blog
  #admin routes
  get "/accounts" => 'admin#accounts', as: :accounts

  get '/dashboard' => 'dashboard#index', as: :dashboard
  get '/profile/:id' => 'dashboard#profile', as: :profile
  post "/agent/message" => "properties#email_agent", as: :email_agent

  root to: 'public#main'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
