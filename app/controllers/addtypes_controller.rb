class AddtypesController < ApplicationController
  before_action :set_addtype, only: [:show, :edit, :update, :destroy]



#返回Json数据
def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
  render json:{code: code, msg: message, count: count,data: data};
end



#获取接口数据
def Get_DataApi
  #获取单据数据
  addtype=Addtype.order(:id);
  #获取单据总数
  total_count=addtype.count
  #分页
  addtype=addtype.page(params[:page]).per(params[:limit])
  #数据转换成Json格式
  data=addtype.as_json;
  #返回Json数据
  api_success(count: total_count,data: data)
end


# 更新单据状态
  def  Update_fbillstatus 
    #提示信息
    message=""
     #事务
    ActiveRecord::Base.transaction do 
      #获取资产类别
    @addtype=Addtype.find(params[:id])
    #判断参数审核状态
    if params[:fbillstatus].lstrip.rstrip=="审核"
      @Fbillstatus="已审核"
    else
      @Fbillstatus="未审核"
    end 
     #单据审核前检验
    message=message+ Update_Fbillstatus_Check("变动方式",params[:id],params[:fbillstatus]).to_s  
     #单据审核检验通过
    if  message.lstrip.rstrip==""
      #更新资产类别状态
      @addtype[0].update(fbillstatus:@Fbillstatus) 
      #如果是审核操作，则更新审核人、审核日期
      if(params[:fbillstatus].lstrip.rstrip=="审核") 
        @addtype[0].update(Approver: session[:name],ApproverDate: Time.now.strftime("%Y-%m-%d %H:%M:%S"))  
      end  
      message=params[:fbillstatus].to_s + "成功！"
    end   
        render :json  => {code: 200,message: message}
  end 
end







  def choose   
    #获取资产类别的姓名、id
    addtype = Addtype.find(params[:addtypeid]) 
    @name = addtype.Name
    @id=   params[:id]   
    render 'choose/choose.js.erb'
  end 

#忽略
  def export_all
    @addtype_all =Addtype.all; 
  end


  #忽略
  def save_multiple  
    params["addtypeid"].each do |i|   
      addtype = Addtype.create!(Addtypecode: i[1][0],Name: i[1][1],Orgainize_id: i[1][2],Description: i[1][3])
    end
  end




#批量删除
  def destroy_multiple    
    #成功数
    sussess=0;
    #失败数
    error=0;
    #返回信息
    message="";
    #根据资产类别id循环
    params["addtype_id"].each do |i| 
      #删除检验
      result=Delete_Check("变动方式",i);    
      
      if(result=="")
        #检验通过，删除成功数+1，进行删除
        sussess+=1;
        Addtype.destroy(i)
      else
         #检验通过，删除失败数+1，返回删除失败原因
        error+=1;
        message=message+result  
      end  
  end
  message="删除成功数：#{sussess}\n"+"删除失败数：#{error}\n"+message;
  render :json  => {code: 200,message: message }
  end



  # GET /addtypes
  # GET /addtypes.json
  def index 
    #忽略
    @q = Addtype.search(params[:q])       
    if  params[:q].nil? 
      @addtypes=Addtype.order(:id).page(params[:page]).per(10)
    else 
      if  params[:q]["name_cont"].lstrip.rstrip==""
        @addtypes=Addtype.order(:id).page(params[:page]).per(10)
      else
        search = params[:q]["search_cont"]
        @addtypes  = Addtype.where( " #{search}  like  ?",  "%#{params[:q]["name_cont"]}%" ).page(params[:page]).per(10)
      end
    end   
  end

  # GET /addtypes/1
  # GET /addtypes/1.json
  def show
  end

  # GET /addtypes/new
  def new
    #创建数据状态默认为“未审核”
    @addtype = Addtype.new
    @addtype.fbillstatus="未审核"
  end

  # GET /addtypes/1/edit
  def edit
  end

  # POST /addtypes
  # POST /addtypes.json
  def create
    @addtype = Addtype.new(addtype_params)
    @addtype.Creator=session[:name] 
    @addtype.CreateDate=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    respond_to do |format|
      if @addtype.save
        format.html { redirect_to @addtype, notice: '变动方式创建成功！' }
        format.json { render :show, status: :created, location: @addtype }
      else
        format.html { render :new }
        format.json { render json: @addtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addtypes/1
  # PATCH/PUT /addtypes/1.json
  def update
    respond_to do |format|
      if @addtype.update(addtype_params)
        format.html { redirect_to @addtype, notice: '变动方式修改成功！' }
        format.json { render :show, status: :ok, location: @addtype }
      else
        format.html { render :edit }
        format.json { render json: @addtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addtypes/1
  # DELETE /addtypes/1.json
  def destroy
    @addtype.destroy
    respond_to do |format|
      format.html { redirect_to addtypes_url, notice: '变动方式删除成功！.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_addtype
      @addtype = Addtype.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def addtype_params
      params.require(:addtype).permit(:Addtypecode, :Name, :Orgainize_id, :Description,:fbillstatus,:Creator,:CreateDate,:Approver,:ApproverDate)
    end
end
