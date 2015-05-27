Rails.application.routes.draw do
  resources :users, :path => '/'
  resources :locations
  root 'users#index'
  #match ':id', :controller => 'users', :action => 'show', :method => 'get'
end
