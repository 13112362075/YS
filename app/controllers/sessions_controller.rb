class SessionsController < ApplicationController
  def new
  end

    def new
      @user=User.new
    end
    
    def create
      @user= User.find_by(account:  params[:session][:account ].downcase) 
      if  @user   &&   @user.password == (params[:session][:password]) 
        store_location
        log_in @user   
        if logon? 
            redirect_back_or root_path
       # redirect_to   root_url
       else
        render 'new' 
      end
    end
  end

    def destroy 
      log_out if logon?
      redirect_to   root_url
    end








  end   