Rails.application.routes.draw do
  resources :assetalter_entries
  resources :assetalters
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
  get 'asset_recoveries_export_all'  ,:to => 'asset_recoveries#export_all'
  get 'asset_turnover_details_export_all'  ,:to => 'asset_turnover_details#export_all'
  get 'asset_allocates_export_all'  ,:to => 'asset_allocates#export_all'
  get 'asset_scrappings_export_all'  ,:to => 'asset_scrappings#export_all'

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
post 'asset_recoveries_save_multiple'  ,:to => 'asset_recoveries#save_multiple'
post 'asset_turnover_details_save_multiple'  ,:to => 'asset_turnover_details#save_multiple'
post 'asset_allocates_save_multiple'  ,:to => 'asset_allocates#save_multiple'
post 'asset_scrappings_save_multiple'  ,:to => 'asset_scrappings#save_multiple'

#弹窗

post 'departments_choose'  ,:to => 'departments#choose'  
post 'users_choose'  ,:to => 'users#choose'  
post 'units_choose'  ,:to => 'units#choose'  
post 'usestates_choose'  ,:to => 'usestates#choose'  
post 'assettypes_choose'  ,:to => 'assettypes#choose'   
post 'addtypes_choose'  ,:to => 'addtypes#choose'   
post 'assetseates_choose'  ,:to => 'assetseates#choose'   
post 'assetstatuses_choose'  ,:to => 'assetstatuses#choose'   
post 'assetcards_choose'  ,:to => 'assetcards#choose'  


#更新资产卡片状态
post 'assetcards_Update_Status'  ,:to => 'assetcards#Update_Status'  


  get 'login'  ,:to => 'sessions#new'  , :as => 'new_sessions'
  post 'login' ,:to   => 'sessions#create'
  delete 'logout', :to  => 'sessions#destroy' 

  get 'get_user'  ,:to => 'sessions#get_user'   



post 'asset_turnover_details_save_all',:to =>'asset_turnover_details#save_all'
post 'asset_allocates_save_all',:to =>'asset_allocates#save_all'
post 'asset_recoveries_save_all',:to =>'asset_recoveries#save_all'
post 'asset_scrappings_save_all',:to =>'asset_scrappings#save_all'


get 'user_test',:to =>'users#test'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 

end
