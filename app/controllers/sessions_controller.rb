class SessionsController < ApplicationController
  def new
    @user=User.new
    if logon?        
       redirect_to homes_path
    end
  end
  

  def get_user
    @userfirst=User.first
    render 'new'  
  end 





  def create 
    session[:account]=params[:session][:account ]
    @user= User.find_by(account:  params[:session][:account ].downcase)  
    respond_to do |format|
    if  @user   &&   @user.password == (params[:session][:password])  
          store_location
          log_in @user   
          if logon?        
                format.html {redirect_to homes_path}  
              else  
                  render 'new'  
          end  
      else
                format.html {redirect_to login_path , notice: '用户密码错误!!!' }  
  end
end
end

  def destroy   
    log_out if logon?  
    redirect_to   root_url
    end
end   