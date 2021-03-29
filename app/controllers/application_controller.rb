class ApplicationController < ActionController::Base
    #引用SessionHelper模块
    include SessionsHelper
    #引用DataCheckHelper模块 
    include DataCheckHelper
    #引用AssetcardsHelper模块
    include AssetcardsHelper
    #引用AssettypesHelper模块
    include AssettypesHelper
end
