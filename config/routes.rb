Rails.application.routes.draw do
  resources :asset_scrapping_entries
  resources :asset_scrappings
  resources :asset_allocate_entries
  resources :asset_recovery_entries
  resources :inventory_plans
  resources :asset_turnover_detail_entries
  resources :asset_allocates
  resources :asset_recoveries
  resources :asset_turnover_details
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
  #批量删除
  post 'destroy_multiple'  ,:to => 'users#destroy_multiple'  
  post 'departments_destroy_multiple'  ,:to => 'departments#destroy_multiple'  
  post 'assettypes_destroy_multiple'  ,:to => 'assettypes#destroy_multiple'  
  post 'assetstatuses_destroy_multiple'  ,:to => 'assetstatuses#destroy_multiple'  
  post 'addtypes_destroy_multiple'  ,:to => 'addtypes#destroy_multiple'  
  post 'assetseates_destroy_multiple'  ,:to => 'assetseates#destroy_multiple'  
  post 'usestates_destroy_multiple'  ,:to => 'usestates#destroy_multiple'  
  post 'units_destroy_multiple'  ,:to => 'units#destroy_multiple'
  post 'assetcards_destroy_multiple'  ,:to => 'assetcards#destroy_multiple'
  post 'asset_recoveries_destroy_multiple'  ,:to => 'asset_recoveries#destroy_multiple'
  post 'asset_turnover_details_destroy_multiple'  ,:to => 'asset_turnover_details#destroy_multiple'
  post 'asset_allocates_destroy_multiple'  ,:to => 'asset_allocates#destroy_multiple'
  post 'asset_scrappings_destroy_multiple'  ,:to => 'asset_scrappings#destroy_multiple'

  get 'users_export_all'  ,:to => 'users#export_all'

  get 'login'  ,:to => 'sessions#new'  , :as => 'new_sessions'
  post 'login' ,:to   => 'sessions#create'
  delete 'logout', :to  => 'sessions#destroy' 

  get 'get_user'  ,:to => 'sessions#get_user'   



post 'asset_turnover_details_save_all',:to =>'asset_turnover_details#save_all'
post 'asset_allocates_save_all',:to =>'asset_allocates#save_all'
post 'asset_recoveries_save_all',:to =>'asset_recoveries#save_all'
post 'asset_scrappings_save_all',:to =>'asset_scrappings#save_all'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
