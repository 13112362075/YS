class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]




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
    params["department_id"].each do |i| 
      Department.destroy(i)
  end
    respond_to do |format|
      format.html { redirect_to departments_url notice: '部门删除成功！.'  }
      format.json { head :no_content }
    end
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
      params.require(:department).permit(:departmentcode, :departmentname, :organize_id, :description)
    end
end
