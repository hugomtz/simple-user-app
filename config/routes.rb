Rails.application.routes.draw do
  resources :users, :path => '/'
  resources :locations
  root 'users#index'
  #match ':id', :controller => 'users', :action => 'show', :method => 'get'
  get "/sessions/log_out" => "sessions#destroy", :as => "log_out"
  get "/sessions/log_in" => "sessions#new", :as => "log_in"
  get "/sessions/sign_up" => "users#new", :as => "sign_up"
  resources :sessions
end
