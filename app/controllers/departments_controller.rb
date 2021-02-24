class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]


  def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
    render json:{code: code, msg: message, count: count,data: data};
  end


  def Get_DataApi
    department=Department.order(:id);
    total_count=department.count
    department=department.page(params[:page]).per(params[:limit])
    data=department.as_json;
    api_success(count: total_count,data: data)
  end




  def  Update_fbillstatus 
    message=""
    ActiveRecord::Base.transaction do
    if params["fbillstatus"].lstrip.rstrip=="审核"
      @status="已审核" 
    else
      @status="未审核"
    end   
    @department  = Department.where( "id =  ? and fbillstatus= ?", params["id"],@status )  
    if    @department.length==0 
      @department = Department.find(params["id"])
      @department[0].update(Approver: session[:name],ApproverDate:Time.now.strftime("%Y-%m-%d %H:%M:%S"),fbillstatus:  @status)

      if message.lstrip.rstrip!="" 
        render :json  => {code: 201,message: message}
        raise ActiveRecord::Rollback 
      else 
      message=  params["fbillstatus"]+"成功！" 
      render :json  => {code: 200,message: message}
      end
    else  
      message=   params[:fbillstatus].lstrip.rstrip+"失败！该部门已经是"+ @status+"状态，不允许"+ params[:fbillstatus]+"\r\n" 
      render :json  => {code: 201,message: message}
    end 
  end 
end



def choose_row
  department = Department.find(params[:departmentid]) 
  @name = department.departmentname
  @id=   params[:id]  
  @Modaltype=  params[:Modaltype] 
  @type="部门";  
  render 'choose/choose_row.js.erb'
end


  def choose   
    department = Department.find(params[:departmentid]) 
    @name = department.departmentname
    @id=   params[:id]  
    @type="部门"; 
    render 'choose/choose.js.erb'
  end


  def export_all
    @department_all =Department.all; 
  end


  
  def save_multiple  
    params["departmentid"].each do |i| 
      puts i[1].length    
      department= Department.create!(departmentcode: i[1][0],departmentname: i[1][1],organize_id: i[1][2],description: i[1][3])
    end
  end



  def destroy_multiple    
    sussess=0;
    error=0;
    message="";
    params["department_id"].each do |i|  
      result=Delete_Check("部门",i);    
      if(result=="")
        sussess+=1;
        Department.destroy(i)
      else
        error+=1; 
        message=message+result  
      end 
  end
  message="删除成功数：#{sussess}\n"+"删除失败数：#{error}\n"+message;
  render :json  => {code: 200,message: message }
  end




  # GET /departments
  # GET /departments.json
  def index 
    

    @q = Department.search(params[:q])      

    if  params[:q].nil? 
      @departments=Department.order(:id).page(params[:page]).per(10)
    else 
      if  params[:q]["name_cont"].lstrip.rstrip==""
        @departments=Department.order(:id).page(params[:page]).per(10)
      else
        search = params[:q]["search_cont"]
        @departments  = Department.where( " #{search}  like  ?",  "%#{params[:q]["name_cont"]}%" ) .page(params[:page]).per(10)
      end
    end   
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    if logon? 
      if Frole?
      else
        log_out if logon?
        redirect_to  new_sessions_path  
      end
    else
      log_out if logon?
      redirect_to  new_sessions_path  
    end
  end

  # GET /departments/new
  def new  
    @department = Department.new
    @department.fbillstatus="未审核"
  end

  # GET /departments/1/edit
  def edit
    if logon? 
      if Frole?  
      else 
        log_out if logon?
        redirect_to  new_sessions_path  
      end
    else 
      log_out if logon?
      redirect_to  new_sessions_path  
    end
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params) 
    @department.Creator=session[:name] 
    @department.CreateDate=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    respond_to do |format|
      if @department.save
        format.html { redirect_to @department, notice: '部门创建成功.' }
        format.json { render :show, status: :created, location: @department }
      else
        format.html { render :new }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to @department, notice: '部门修改成功！.' }
        format.json { render :show, status: :ok, location: @department }
      else
        format.html { render :edit }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to departments_url, notice: 'Department was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def department_params
      params.require(:department).permit(:departmentcode, :departmentname, :organize_id, :description,:fbillstatus,:Creator,:CreateDate,:Approver,:ApproverDate)
    end
end
