class HomesController < ApplicationController
  def index  
    if !logon?
      redirect_to root_path
    end
    if  session[:IsFirst] =="False"
      session[:IsRresh] ="False";
    end 
    if   session[:IsFirst] =="True"
      session[:IsFirst]="False";
    end
    @session=session[:name] 
  end
end
