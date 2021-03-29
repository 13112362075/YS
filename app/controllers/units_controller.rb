class UnitsController < ApplicationController
  before_action :set_unit, only: [:show, :edit, :update, :destroy]

#返回Json数据
  def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
    render json:{code: code, msg: message, count: count,data: data};
  end



  #获取接口数据
  def Get_DataApi
    #获取单据数据
    unit=Unit.order(:id);
    #获取单据总数
    total_count=unit.count
    #分页
    unit=unit.page(params[:page]).per(params[:limit])
    #数据转换成Json格式
    data=unit.as_json;
    #返回Json数据
    api_success(count: total_count,data: data)
  end

 

#更新状态
def  Update_fbillstatus 
  #返回信息
  message=""
  #事务
    ActiveRecord::Base.transaction do  
    @unit=Unit.find(params[:id]) 
    if params[:fbillstatus].lstrip.rstrip=="审核"
      @Fbillstatus="已审核"
    else
      @Fbillstatus="未审核"
    end 
            #更新状态检验
    message=message+ Update_Fbillstatus_Check("计量单位",params[:id],params[:fbillstatus]).to_s   
    if  message.lstrip.rstrip==""
            #检验通过
      @unit[0].update(fbillstatus:@Fbillstatus)
      if(params[:fbillstatus].lstrip.rstrip=="审核")
                                #审核操作更新审核人、审核日期
        @unit[0].update(Approver: session[:name],ApproverDate: Time.now.strftime("%Y-%m-%d %H:%M:%S"))  
      end  
      message=params[:fbillstatus].to_s + "成功！"
    end   
        render :json  => {code: 200,message: message}
  end 
end

#基础资料 
  def choose   
    unit = Unit.find(params[:unitid]) 
    @name = unit.name
    @id=   params[:id] 
    render 'choose/choose.js.erb'
  end

#忽略
  def export_all
    @unit_all =Unit.all; 
  end


  #忽略
  def save_multiple  
    params["unitid"].each do |i|    
      unit = Unit.create!(Unitcode: i[1][0],name: i[1][1],Unitaccuracy: i[1][2],Roundingtype: i[1][3]) 
    end
  end




  #删除
  def destroy_multiple    
    #成功数
    sussess=0;
    #失败数
    error=0;
    #返回信息
    message="";
    params["unit_id"].each do |i| 
      #删除检验
      result=Delete_Check("计量单位",i);     
      if(result=="")
        #检验通过，成功数+1，删除计量单位
        sussess+=1;
        Unit.destroy(i)
      else
        #检验不通过，失败数+1
        error+=1;
        message=message+result  
      end 
  end 
  message="删除成功数：#{sussess}\n"+"删除失败数：#{error}\n"+message;
  render :json  => {code: 200,message: message }
end



 

  # GET /units
  # GET /units.json
  #忽略
  def index 
    @q = Unit.search(params[:q])      

    if  params[:q].nil? 
      @units=Unit.order(:id).page(params[:page]).per(10)
    else 
      if  params[:q]["name_cont"].lstrip.rstrip==""
        @units=Unit.order(:id).page(params[:page]).per(10)
      else
        search = params[:q]["search_cont"]
        @units  = Unit.where( " #{search}  like  ?",  "%#{params[:q]["name_cont"]}%" ) .page(params[:page]).per(10)
      end
  end
end

  # GET /units/1
  # GET /units/1.json
  def show
  end

  # GET /units/new
  def new
    @unit = Unit.new
    #新增单位时，单据状态默认为未审核
    @unit.fbillstatus="未审核"
  end

  # GET /units/1/edit
  def edit
  end

  # POST /units
  # POST /units.json
  def create
    @unit = Unit.new(unit_params)
    @unit.Creator=session[:name] 
    @unit.CreateDate=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    respond_to do |format|
      if @unit.save
        format.html { redirect_to @unit, notice: '创建成功！.' }
        format.json { render :show, status: :created, location: @unit }
      else
        format.html { render :new }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /units/1
  # PATCH/PUT /units/1.json
  def update
    respond_to do |format|
      if @unit.update(unit_params)
        format.html { redirect_to @unit, notice: '修改成功！.' }
        format.json { render :show, status: :ok, location: @unit }
      else
        format.html { render :edit }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1
  # DELETE /units/1.json
  def destroy
    @unit.destroy
    respond_to do |format|
      format.html { redirect_to units_url, notice: '删除成功！' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit
      @unit = Unit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def unit_params
      params.require(:unit).permit(:Unitcode, :name, :Unitaccuracy, :Roundingtype,:fbillstatus,:Creator,:CreateDate,:Approver,:ApproverDate)
    end
end
