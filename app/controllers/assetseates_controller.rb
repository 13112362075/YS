class AssetseatesController < ApplicationController
  before_action :set_assetseate, only: [:show, :edit, :update, :destroy]



#返回Json数据
def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
  render json:{code: code, msg: message, count: count,data: data};
end



#获取接口数据
def Get_DataApi
  #获取单据数据
  assetseate=Assetseate.order(:id);
  #获取单据总数
  total_count=assetseate.count
  #分页
  assetseate=assetseate.page(params[:page]).per(params[:limit])
  #数据转换成Json格式
  data=assetseate.as_json;
  #返回Json数据
  api_success(count: total_count,data: data)
end


#更新状态
  def  Update_fbillstatus 
    #返回信息
    message=""
    #事务
    ActiveRecord::Base.transaction do  
    @assetseate=Assetseate.find(params[:id]) 
    if params[:fbillstatus].lstrip.rstrip=="审核"
      @Fbillstatus="已审核"
    else
      @Fbillstatus="未审核"
    end 
    #更新状态检验
    message=message+ Update_Fbillstatus_Check("资产位置",params[:id],params[:fbillstatus]).to_s   
    if  message.lstrip.rstrip==""
      #检验通过
      @assetseate[0].update(fbillstatus:@Fbillstatus)
      if(params[:fbillstatus].lstrip.rstrip=="审核")
        #审核操作更新审核人、审核日期
        @assetseate[0].update(Approver: session[:name],ApproverDate: Time.now.strftime("%Y-%m-%d %H:%M:%S"))  
      end  
      message=params[:fbillstatus].to_s + "成功！"
    end   
        render :json  => {code: 200,message: message}
  end 
end




#选择基础资料（单据体）
  def choose_row
    assetseate = Assetseate.find(params[:assetseateid]) 
    @name = assetseate.Name
    @Modaltype=  params[:Modaltype] 
    @id=   params[:id] 
    render 'choose/choose_row.js.erb'
  end 



#选择基础资料（单据头）
  def choose    
    assetseate = Assetseate.find(params[:assetseateid]) 
    @name = assetseate.Name
    @id=   params[:id] 
    render 'choose/choose.js.erb'
  end 

 #忽略
  def export_all
    @assetseate_all =Assetseate.all; 
  end


  #忽略
  def save_multiple  
    params["assetseateid"].each do |i|   
      assetseate = Assetseate.create!(Assetseatecode: i[1][0],Name: i[1][1],Orgainize_id: i[1][2],Description: i[1][3]) 
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
    params["assetseate_id"].each do |i| 
      #删除检验
      result=Delete_Check("资产位置",i);     
      if(result=="")
        #检验通过，成功数+1，删除资产位置
        sussess+=1;
        Assetseate.destroy(i)
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
  # GET /assetseates
  # GET /assetseates.json
  def index  
    @q = Assetseate.search(params[:q])      

    if  params[:q].nil? 
      @assetseate=Assetseate.order(:id).page(params[:page]).per(10)
    else 
      if  params[:q]["name_cont"].lstrip.rstrip==""
        @assetseate=Assetseate.order(:id).page(params[:page]).per(10)
      else
        search = params[:q]["search_cont"]
        @assetseate  = Assetseate.where( " #{search}  like  ?",  "%#{params[:q]["name_cont"]}%" ) .page(params[:page]).per(10)
      end
    end   
  end

  # GET /assetseates/1
  # GET /assetseates/1.json 
  def show
  end

  # GET /assetseates/new
  def new
    @assetseate = Assetseate.new
    @assetseate.fbillstatus="未审核"
  end

  # GET /assetseates/1/edit
  def edit
  end

  # POST /assetseates
  # POST /assetseates.json
  def create
    @assetseate = Assetseate.new(assetseate_params)
    @assetseate.Creator=session[:name] 
    @assetseate.CreateDate=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    respond_to do |format|
      if @assetseate.save
        format.html { redirect_to @assetseate, notice: '创建成功！' }
        format.json { render :show, status: :created, location: @assetseate }
      else
        format.html { render :new }
        format.json { render json: @assetseate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assetseates/1
  # PATCH/PUT /assetseates/1.json
  def update
    respond_to do |format|
      if @assetseate.update(assetseate_params)
        format.html { redirect_to @assetseate, notice: '修改成功！' }
        format.json { render :show, status: :ok, location: @assetseate }
      else
        format.html { render :edit }
        format.json { render json: @assetseate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assetseates/1
  # DELETE /assetseates/1.json
  def destroy
    @assetseate.destroy
    respond_to do |format|
      format.html { redirect_to assetseates_url, notice: '删除成功！' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assetseate
      @assetseate = Assetseate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assetseate_params
      params.require(:assetseate).permit(:Assetseatecode, :Name, :Orgainize_id, :Description,:fbillstatus,:Creator,:CreateDate,:Approver,:ApproverDate)
    end
end
