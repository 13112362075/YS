module SessionsHelper 

    def IsRresh()
        if(session[:IsRresh_2] =="true")
            session[:IsRresh_2] ="false";
        else
            session[:IsRresh_2] ="true";
        end
    end

    def log_in(user)
        session[:user_id]=user.id
        @user=User.find(user.id)
        session[:role]=@user.role
        session[:name]=@user.name 
        session[:IsRresh_2] ="true";
        session[:IsRresh] ="True";
        session[:IsFirst] ="True";

        #@curreny_user= User.find_by(email:  user.email.downcase)
    end

    def logon? #判断用户是否登陆
        !session[:user_id].nil?
     #!@user1.nil?
    end
      
    def Frole?  #判断用户是否为管理员
        if session[:role]=="0"
            return false
        else
            return true
        end 
    end

    def log_out
        session.delete(:user_id)
       @user1=nil
    end
 

# 重定向到存储的地址或默认地址
def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
end
# 存储以后需要的地址
def store_location
    session[:forwarding_url] = request.url if request.get?
end 

end
