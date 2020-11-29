Rails.application.routes.draw do
  resources :asset_allocate_entries
  resources :asset_allocates
  resources :asset_turnover_detail_entries
  resources :asset_turnover_details
  resources :asset_recovery_entries
  resources :asset_recoveries
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

  post 'destroy_multiple'  ,:to => 'users#destroy_multiple'  
  post 'departments_destroy_multiple'  ,:to => 'departments#destroy_multiple'  
  post 'assettypes_destroy_multiple'  ,:to => 'assettypes#destroy_multiple'  
  post 'assetstatuses_destroy_multiple'  ,:to => 'assetstatuses#destroy_multiple'  
  post 'addtypes_destroy_multiple'  ,:to => 'addtypes#destroy_multiple'  
  post 'assetseates_destroy_multiple'  ,:to => 'assetseates#destroy_multiple'  
  post 'usestates_destroy_multiple'  ,:to => 'usestates#destroy_multiple'  
  post 'units_destroy_multiple'  ,:to => 'units#destroy_multiple'
  post 'assetcards_destroy_multiple'  ,:to => 'assetcards#destroy_multiple'
  #导入
  post 'save_multiple'  ,:to => 'users#save_multiple'  
  post 'departments_save_multiple'  ,:to => 'departments#save_multiple'
  post 'assettypes_save_multiple'  ,:to => 'assettypes#save_multiple'
  post 'assetstatuses_save_multiple'  ,:to => 'assetstatuses#save_multiple'
  post 'addtypes_save_multiple'  ,:to => 'addtypes#save_multiple'
  post 'assetseates_save_multiple'  ,:to => 'assetseates#save_multiple'
  post 'usestates_save_multiple'  ,:to => 'usestates#save_multiple'
  post 'units_save_multiple'  ,:to => 'units#save_multiple' 
  post 'assetcards_save_multiple'  ,:to => 'assetcards#save_multiple' 
  #导入
#导出
  get 'users_export_all'  ,:to => 'users#export_all'
  get 'departments_export_all'  ,:to => 'departments#export_all'
  get 'assettypes_export_all'  ,:to => 'assettypes#export_all'
  get 'assetstatuses_export_all'  ,:to => 'assetstatuses#export_all'
  get 'addtypes_export_all'  ,:to => 'addtypes#export_all'
  get 'assetseates_export_all'  ,:to => 'assetseates#export_all'
  get 'usestates_export_all'  ,:to => 'usestates#export_all'
  get 'units_export_all'  ,:to => 'units#export_all' 
  get 'assetcards_export_all'  ,:to => 'assetcards#export_all' 
#导出
  get 'login'  ,:to => 'sessions#new'  , :as => 'new_sessions'
  post 'login' ,:to   => 'sessions#create'
  delete 'logout', :to  => 'sessions#destroy' 

  get 'get_user'  ,:to => 'sessions#get_user'   
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
