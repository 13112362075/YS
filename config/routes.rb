Rails.application.routes.draw do
  resources :assetstatuses
  resources :assettypes
 root 'homes#index'
  resources :departments
  resources :users
  get 'login'  ,:to => 'sessions#new'  , :as => 'new_sessions'
  post 'login' ,:to   => 'sessions#create'
  delete 'logout', :to  => 'sessions#destroy' 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
