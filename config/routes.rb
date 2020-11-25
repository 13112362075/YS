Rails.application.routes.draw do
  resources :assetcards
  resources :assetseates
  resources :usestates
  resources :addtypes
  resources :units
  resources :assetstatuses
  resources :assettypes
 root 'sessions#new'
  resources :departments
 

  resources :users  
 
  get 'homes'  ,:to => 'homes#index'  , :as => 'homes'
  post 'save_multiple'  ,:to => 'users#save_multiple'  
  post 'destroy_multiple'  ,:to => 'users#destroy_multiple'  
  post 'departments_destroy_multiple'  ,:to => 'departments#destroy_multiple'  
  post 'assettypes_destroy_multiple'  ,:to => 'assettypes#destroy_multiple'  
  post 'assetstatuses_destroy_multiple'  ,:to => 'assetstatuses#destroy_multiple'  
  post 'addtypes_destroy_multiple'  ,:to => 'addtypes#destroy_multiple'  
  post 'assetseates_destroy_multiple'  ,:to => 'assetseates#destroy_multiple'  
  post 'usestates_destroy_multiple'  ,:to => 'usestates#destroy_multiple'  
  post 'units_destroy_multiple'  ,:to => 'units#destroy_multiple'
  post 'assetcards_destroy_multiple'  ,:to => 'assetcards#destroy_multiple'
  get 'users_export_all'  ,:to => 'users#export_all'

  get 'login'  ,:to => 'sessions#new'  , :as => 'new_sessions'
  post 'login' ,:to   => 'sessions#create'
  delete 'logout', :to  => 'sessions#destroy' 

  get 'get_user'  ,:to => 'sessions#get_user'   
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
