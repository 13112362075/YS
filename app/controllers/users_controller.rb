class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy] 

 

  #返回Json数据
  def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
    render json:{code: code, msg: message, count: count,data: data};
  end

#选择基础资料（单据体）
  def choose_row
    user = User.find(params[:userid]) 
    @name = user.name
    @departmentname = user.departmentname 
    @id=   params[:id]  
    @id[4]=    @departmentname 
    @Modaltype=  params[:id][2]
    @type="用户";  
    render 'choose/choose_row.js.erb'  
  end 
  #忽略
  def  GetDataApi
    # if (params.include? 'key'  ) 
    #   sql=" SELECT * FROM  users  where 1=1  and name ='#{params[:key][:username]}' " 
    #   user =User.find_by_sql (sql)
    #   puts user.length
    # else 
    #   user=User.order(:id);
    # end 
    user=User.order(:id);
    total_count=user.count
    user=user.page(params[:page]).per(params[:limit])
    data=user.as_json;
    api_success(count: total_count,data: data)
  end

#选择基础资料（单据头）
  def choose   
    user = User.find(params[:userid]) 
    @name = user.name
    @departmentname = user.departmentname 
    @id=   params[:id]  
    @id[4]=    @departmentname 
    render 'choose/choose.js.erb'
  end 

 
 #忽略
  def export_all
    @user_all =User.all; 
  end


#忽略  
  def save_multiple    
    if Frole?
      ActiveRecord::Base.transaction do 
        params["userid"].each do |i|  
          user = User.create!(account: i[1][0],password: i[1][1],name: i[1][2],address: i[1][3],email: i[1][4], telephone: i[1][5],sex: i[1][6],role: i[1][7],departmentname: i[1][8],orgainize_id: i[1][9])
        end
      end  
    else
      message="导入失败！只有管理员才允许进行导入操作！";
      render :json  => {code: 200,message: message }
    end 
end




def destroy_multiple
  if Frole?
    #成功数
    sussess=0;
    #失败数
    error=0;
        #返回信息
  message="";
 # ActiveRecord::Base.transaction do
    params["userid"].each do |i|  
      @user=User.find(i)  
            #删除检验
      result=Delete_Check("用户",@user.id);    
      if(result=="") 
                #检验通过，成功数+1，删除用户
        sussess+=1;
        User.destroy(i) 
         #raise ActiveRecord::RecordNotFound 
      else 
                #检验不通过，失败数+1
        error+=1;
        message=message+result  
        #raise ActiveRecord::RecordNotFound  
      end  
    end 
 # end
    #rescue ActiveRecord::RecordNotFound => exception 
    message="删除成功数：#{sussess}\n"+"删除失败数：#{error}\n"+message;
    render :json  => {code: 200,message: message }
  else
    message="删除失败！只有管理员才允许进行删除操作！";
    render :json  => {code: 200,message: message }
  end
  
end 
  
 #忽略
  def index   
    @q = User.search(params[:q])  
    if  params[:q].nil?
    #  @users = User.all 
      @users=User.order(:id).page(params[:page]).per(5) 
    else 
      if  params[:q]["name_cont"].lstrip.rstrip==""
        #  @users = User.all
        @users=User.order(:id).page(params[:page]).per(5) 
      else
        search = params[:q]["search_cont"] 
        @users  = User.where( " #{search}  like  ?",  "%#{params[:q]["name_cont"].lstrip.rstrip}%" ) .page(params[:page]).per(5)
      end
    end 
    @department= Department.all  
    @user=User.new
  end

 

  # GET /users/1
  # GET /users/1.json
  def show
    @department = Department.all   
  end
  # GET /users/new


  def new
    @user = User.new 
    @department = Department.all   
  end


  

  # GET /users/1/edit
  # GET /users/1/edit
  def edit  
    @user=User.find(params["id"]);
    @department = Department.all
    render 'users/edit.js.erb'  
  end


  
  # POST /users
  # POST /users.json
  def create
    @department = Department.all 
    if params[:id]=="0"
      @user = User.new(account:params[:account],password:params[:password],name:params[:name],address:params[:address], email:params[:email],telephone:params[:telephone],sex:params[:sex],role:params[:role],departmentname:params[:departmentname],orgainize_id:params[:orgainize_id]) 
      @user.save
    else
      @user=User.find(params[:id]);
      @user.update(account:params[:account],password:params[:password],name:params[:name],address:params[:address], email:params[:email],telephone:params[:telephone],sex:params[:sex],role:params[:role],departmentname:params[:departmentname],orgainize_id:params[:orgainize_id]) 
      #@user.update(user_params);

    end 
    render :json  => {code: 200,message: "保存成功！" }
    #@user.save
    #  respond_to do |format|
    #   if @user.save
    #     format.html { redirect_to @user, notice: '用户创建成功！' }
    #     format.json { render :show, status: :created, location: @user }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format| 
    @department = Department.all  
      if @user.update(user_params)
        format.html { redirect_to @user, notice:'用户修改成功！'}
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: '用户删除成功！.' }
      format.json { head :no_content }
    end
  end

   
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:account, :password, :name, :address, :email, :telephone, :sex, :role, :departmentname, :orgainize_id)
    end
end
