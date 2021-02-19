Rails.application.routes.draw do
  resources :asset_loss_entries
  resources :asset_gain_entries
  resources :asset_gains
  resources :asset_losses
  resources :asset_countingreports
  resources :asset_countingreport_entries
  resources :asset_allocate_entries
  resources :asset_allocates
  resources :asset_disposal_entries
  resources :asset_disposals
  resources :asset_scrapping_entries
  resources :asset_pickings
  resources :asset_picking_entries
  resources :assetalters
  resources :inventory_plans
  resources :asset_turnover_detail_entries
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
  post 'asset_pickings_destroy_multiple'  ,:to => 'asset_pickings#destroy_multiple'
  post 'assetalters_destroy_multiple'  ,:to => 'assetalters#destroy_multiple'
  post 'asset_disposals_destroy_multiple'  ,:to => 'asset_disposals#destroy_multiple'
  post 'asset_countingreports_destroy_multiple'  ,:to => 'asset_countingreports#destroy_multiple'
   
post 'asset_gains_destroy_multiple',:to => 'asset_gains#destroy_multiple'
post 'asset_losses_destroy_multiple',:to => 'asset_losses#destroy_multiple'
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
#选择基础资料
post 'departments_choose'  ,:to => 'departments#choose'  
post 'users_choose'  ,:to => 'users#choose'  
post 'units_choose'  ,:to => 'units#choose'  
post 'usestates_choose'  ,:to => 'usestates#choose'  
post 'assettypes_choose'  ,:to => 'assettypes#choose'   
post 'addtypes_choose'  ,:to => 'addtypes#choose'   
post 'assetseates_choose'  ,:to => 'assetseates#choose'   
post 'assetstatuses_choose'  ,:to => 'assetstatuses#choose'   
post 'assetcards_choose'  ,:to => 'assetcards#choose'  
post 'assetcards_choose_single'  ,:to => 'assetcards#choose_single'  
post 'assetseates_choose_row'  ,:to => 'assetseates#choose_row'  

#更新资产卡片状态
post 'assetcards_Update_Status'  ,:to => 'assetcards#Update_Status'   

  get 'login'  ,:to => 'sessions#new'  , :as => 'new_sessions'
  post 'login' ,:to   => 'sessions#create'
  delete 'logout', :to  => 'sessions#destroy' 

  get 'get_user'  ,:to => 'sessions#get_user'   


#单据头单据体一起保存
post 'asset_turnover_details_save_all',:to =>'asset_turnover_details#save_all'
post 'asset_allocates_save_all',:to =>'asset_allocates#save_all'
post 'asset_recoveries_save_all',:to =>'asset_recoveries#save_all'
post 'asset_scrappings_save_all',:to =>'asset_scrappings#save_all'
post 'asset_pickings_save_all',:to =>'asset_pickings#save_all'
post 'assetalters_save_all',:to =>'assetalters#save_all'
post 'asset_disposals_save_all',:to =>'asset_disposals#save_all'
post 'asset_countingreports_save_all',:to =>'asset_countingreports#save_all'
post 'asset_gains_save_all',:to => 'asset_gains#save_all'
post 'asset_losses_save_all',:to => 'asset_losses#save_all'
#获取数据接口
get 'user_test',:to =>'users#test'
get 'assetalters_Get_Data',:to =>'assetalters#Get_DataApi'
get 'AssetList_Get_Data',:to =>'asset_list#Get_DataApi'
get 'asset_expiration_warning_Get_Data',:to =>'asset_expiration_warning#Get_DataApi'
get 'asset_pickings_Get_Data',:to =>'asset_pickings#Get_DataApi' 
get 'asset_disposals_Get_Data',:to =>'asset_disposals#Get_DataApi' 
get 'asset_allocates_Get_Data',:to =>'asset_allocates#Get_DataApi' 
get 'asset_countingreports_Get_Data',:to =>'asset_countingreports#Get_DataApi' 
get 'asset_gains_Get_DataApi',:to => 'asset_gains#Get_DataApi'
get 'asset_losses_Get_DataApi',:to => 'asset_losses#Get_DataApi'
get 'asset_turnover_details_Get_DataApi',:to => 'asset_turnover_details#Get_DataApi'
#更新状态
post 'assetcards_Update_Fbillstatus',:to => 'assetcards#Update_Fbillstatus'
post 'asset_turnover_details_Update_Fbillstatus',:to => 'asset_turnover_details#Update_Fbillstatus'
post 'assetalters_Update_Fbillstatus',:to => 'assetalters#Update_Fbillstatus'
post 'asset_pickings_Update_Fbillstatus',:to => 'asset_pickings#Update_fbillstatus'
post 'asset_disposals_Update_Fbillstatus',:to => 'asset_disposals#Update_fbillstatus'
post 'asset_allocates_Update_Fbillstatus',:to => 'asset_allocates#Update_fbillstatus'
post 'asset_countingreports_Update_Fbillstatus',:to => 'asset_countingreports#Update_fbillstatus'
post 'asset_gains_Update_Fbillstatus',:to => 'asset_gains#Update_fbillstatus'
post 'asset_losses_Update_Fbillstatus',:to => 'asset_losses#Update_fbillstatus'
#判断是否存在未审核的资产变更单
get 'assetalters_Check_IsExist',:to => 'assetalters#Check_IsExist'

#资产实物清单
get 'AssetList_show',:to => 'asset_list#show'
#资产到期预警
get 'asset_expiration_warning_show',:to => 'asset_expiration_warning#show'

#登录界面 
post 'sessions_Login_user',:to => 'sessions#Login_user'

#检查是否允许下推
get 'asset_pickings_Check_IsPush',:to => 'asset_pickings#Check_IsPush'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 

end
