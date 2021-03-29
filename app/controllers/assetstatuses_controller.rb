class AssetstatusesController < ApplicationController
  before_action :set_assetstatus, only: [:show, :edit, :update, :destroy]

  #返回Json数据
  def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
    render json:{code: code, msg: message, count: count,data: data};
  end


  #获取接口数据
  def Get_DataApi
    #获取单据数据
    assetstatus=Assetstatus.order(:id);
    #获取单据总数
    total_count=assetstatus.count
    #分页
    assetstatus=assetstatus.page(params[:page]).per(params[:limit])
    #数据转换成Json格式
    data=assetstatus.as_json;
    #返回Json数据
    api_success(count: total_count,data: data)
  end

 

#更新状态
  def  Update_fbillstatus 
    #返回信息
    message=""
    #事务
    ActiveRecord::Base.transaction do  
    @assetstatus=Assetstatus.find(params[:id]) 
    if params[:fbillstatus].lstrip.rstrip=="审核"
      @Fbillstatus="已审核"
    else
      @Fbillstatus="未审核"
    end 
    #更新状态检验
    message=message+ Update_Fbillstatus_Check("资产状态",params[:id],params[:fbillstatus]).to_s   
    if  message.lstrip.rstrip=="" 
      #检验通过
      @assetstatus[0].update(fbillstatus:@Fbillstatus)
      if(params[:fbillstatus].lstrip.rstrip=="审核")
                #审核操作更新审核人、审核日期
        @assetstatus[0].update(Approver: session[:name],ApproverDate: Time.now.strftime("%Y-%m-%d %H:%M:%S"))  
      end  
      message=params[:fbillstatus].to_s + "成功！"
    end   
        render :json  => {code: 200,message: message}
  end 
end


#选择基础资料（单据体）
  def choose   
    assetstatus = Assetstatus.find(params[:assetstatusid]) 
    @name = assetstatus.Name
    @id=   params[:id] 
    render 'choose/choose.js.erb'
  end 

  #忽略
  def export_all
    @assetstatus_all =Assetstatus.all; 
  end


  #忽略
  def save_multiple   
    params["assetstatuseid"].each do |i|  
      assetstatus = Assetstatus.create!(Assetstatuscode: i[1][0],Name: i[1][1],Orgainize_id: i[1][2],description: i[1][3])
 
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
    params["assetstatuse_id"].each do |i| 
      #删除检验
      result=Delete_Check("资产状态",i);     
      if(result=="")
        #检验通过，成功数+1，删除资产状态
        sussess+=1;
        Assetstatus.destroy(i)
      else
        #检验不通过，失败数+1
        error+=1;
        message=message+result  
      end 
  end 
  message="删除成功数：#{sussess}\n"+"删除失败数：#{error}\n"+message;
  render :json  => {code: 200,message: message }
end
  

 
#忽略
  # GET /assetstatuses
  # GET /assetstatuses.json
  def index 

    @q = Assetstatus.search(params[:q])      

    if  params[:q].nil? 
      @assetstatuses=Assetstatus.order(:id).page(params[:page]).per(10)
    else 
      if  params[:q]["name_cont"].lstrip.rstrip==""
        @assetstatuses=Assetstatus.order(:id).page(params[:page]).per(10)
      else
        search = params[:q]["search_cont"]
        @assetstatuses  = Assetstatus.where( " #{search}  like  ?",  "%#{params[:q]["name_cont"]}%" ).page(params[:page]).per(10)
      end
    end  



  end

  # GET /assetstatuses/1
  # GET /assetstatuses/1.json
  def show
  end

  # GET /assetstatuses/new
  def new
    @assetstatus = Assetstatus.new
    @assetstatus.fbillstatus="未审核"
  end

  # GET /assetstatuses/1/edit
  def edit
  end

  # POST /assetstatuses
  # POST /assetstatuses.json
  def create
    @assetstatus = Assetstatus.new(assetstatus_params)
    @assetstatus.Creator=session[:name] 
    @assetstatus.CreateDate=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    respond_to do |format|
      if @assetstatus.save
        format.html { redirect_to @assetstatus, notice: '创建成功！' }
        format.json { render :show, status: :created, location: @assetstatus }
      else
        format.html { render :new }
        format.json { render json: @assetstatus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assetstatuses/1
  # PATCH/PUT /assetstatuses/1.json
  def update
    respond_to do |format|
      if @assetstatus.update(assetstatus_params)
        format.html { redirect_to @assetstatus, notice: '修改成功！.' }
        format.json { render :show, status: :ok, location: @assetstatus }
      else
        format.html { render :edit }
        format.json { render json: @assetstatus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assetstatuses/1
  # DELETE /assetstatuses/1.json
  def destroy
    @assetstatus.destroy
    respond_to do |format|
      format.html { redirect_to assetstatuses_url, notice: '删除成功！' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assetstatus
      @assetstatus = Assetstatus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assetstatus_params
      params.require(:assetstatus).permit(:Assetstatuscode, :Name, :Orgainize_id, :description,:fbillstatus,:Creator,:CreateDate,:Approver,:ApproverDate)
    end
end
