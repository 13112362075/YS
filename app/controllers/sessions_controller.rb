class SessionsController < ApplicationController
  def new
    @user=User.new
    if logon?      
      puts "1" ; 
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

      if params[:session][:account ]==""
        format.html {redirect_to login_path , notice: '用户名不允许为空！' }   
      else 
        if  params[:session][:password ]==""
          format.html {redirect_to login_path , notice: '密码不允许为空！' }  
        else 
          if  @user   &&   @user.password == (params[:session][:password])  
            store_location
            log_in @user   
            if logon?        
                  format.html {redirect_to homes_path}  
                else  
                    render 'new'  
            end  
          else
                  format.html {redirect_to login_path , notice: '您输入的用户名或密码不正确，请重新输入!' }  
          end
        end  
      end
    end
  end

  def destroy   
    log_out if logon?  
    redirect_to   root_url
    end
end   