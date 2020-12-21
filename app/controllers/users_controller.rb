class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy] 

  def choose   
    user = User.find(params[:userid]) 
    @name = user.name
    @departmentname = user.departmentname 
    @id=   params[:id]  
    @id[3]=    @departmentname 
    render 'choose/choose.js.erb'
  end 

 
 
  def export_all
    @user_all =User.all; 
  end


  
  def save_multiple    
    ActiveRecord::Base.transaction do 
    params["userid"].each do |i|  
      user = User.create!(account: i[1][0],password: i[1][1],name: i[1][2],address: i[1][3],email: i[1][4], telephone: i[1][5],sex: i[1][6],role: i[1][7],departmentname: i[1][8],orgainize_id: i[1][9])
    end
  end  
end

 
def destroy_multiple
  sussess=0;
  error=0;
  message="";
 # ActiveRecord::Base.transaction do
    params["userid"].each do |i|  
      @user=User.find(i) 
      if(@user.role=="管理员")
        error+=1;
        message=message+"用户名为 ：#{@user.name} 为管理员，不允许删除!\n"
        next;
      end 
      if(@user.name==session[:name] )
        error+=1;
        message=message+"用户名为 ：#{@user.name} 为当前登录用户，不允许删除!\n"
        next;
      end
      result=Delete_Check("用户",@user.name);    
      if(result=="false") 
        sussess+=1;
        User.destroy(i) 
         #raise ActiveRecord::RecordNotFound 
      else 
        error+=1;
        message=message+"用户名为 ：#{@user.name} 已被占用，无法删除!\n"
        #raise ActiveRecord::RecordNotFound  
      end  
    end 
 # end
    #rescue ActiveRecord::RecordNotFound => exception 
    message="删除成功数：#{sussess}\n"+"删除失败数：#{error}\n"+message;
    render :json  => {code: 200,message: message }
end 
 
 
  def index   
    @q = User.search(params[:q]) 
    puts @q;
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
    @department = Department.all
  end


  
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @department = Department.all  
    puts    @department.length
     respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: '用户创建成功！' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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
