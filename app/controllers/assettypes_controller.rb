class AssettypesController < ApplicationController
  before_action :set_assettype, only: [:show, :edit, :update, :destroy]

#判断资产类别是否最底层、审核状态
def Check_Assettype
  #返回信息
  message=""
  #判断是资产类别列表点击的还是资产卡片
  if params[:type].lstrip.rstrip=="资产类别"
    message=message+Check_IsAudit(params[:Name])#判断资产类别是否审核
  elsif params[:type].lstrip.rstrip=="资产卡片"
    message=message+Check_IsLowesLevel(params[:Name])#判断资产类别是否为最底层
  end
  if message.lstrip.rstrip==""
    render :json  => {code: 200,message: message}
  else
    render :json  => {code: 201,message: message}
  end
end

#返回Json数据  
  def api_success(type: 0,code: 0,message:'请求成功', count: '3',data:{}) 
    #type==0 获取资产类别列表
    #type==1 获取资产树状列表
    render json:{type:type,code: code, msg: message, count: count,data: data};
  end
  
#获取树状Json数据
  def Get_Data_Tree_Api 
    sql="  select '资产类型-列表' as Name,0 as 'id', 0 as 'pid' union all select  A.`Name`,A.id, IFNULL(B.id,0) as 'pid' from assettypes A left join assettypes B ON A.ParentAssettype= B.`Name` "
    @assettype=Assettype.find_by_sql (sql)    
    render 'tree' 
    #api_success(type: 1,data: data)
  end

#获取数据接口
  def Get_DataApi
    if (params.include? 'key')  
      if params[:key][:Assettype_selected].lstrip.rstrip=="资产类型-列表" 
        #如果选择的资产类型=资产类型-列表，则返回第一级资产类型
        sql=" select  * from assettypes  where ParentAssettype is NULL"
      else
        #返回上级资产类别等于所选类别的资产类别
        sql=" select  * from assettypes  where ParentAssettype = '#{params[:key][:Assettype_selected]}'"
      end 
      assettype=Assettype.find_by_sql (sql)
      #转换成collection格式
      assettype.map{|i| i.id}
      assettype = Assettype.where(:id => assettype) 
    else
      assettype=Assettype.order(:id); 
    end 
    #返回总数
    total_count=assettype.count
    #分页
    assettype=assettype.page(params[:page]).per(params[:limit])
    #转换成Json数据
    data=assettype.as_json;
    #返回Json数据
    api_success(type: 0,count: total_count,data: data)
  end





#更新状态
def  Update_fbillstatus 
  #返回信息
  message=""
  #事务
  ActiveRecord::Base.transaction do  
    @assettype=Assettype.find(params[:id]) 
  if params[:fbillstatus].lstrip.rstrip=="审核"
    @Fbillstatus="已审核"
  else
    @Fbillstatus="未审核"
  end 
  #更新状态检验
  message=message+ Update_Fbillstatus_Check("资产类别",params[:id],params[:fbillstatus]).to_s   
  if  message.lstrip.rstrip==""
    #检验通过
    @assettype[0].update(fbillstatus:@Fbillstatus)
    if(params[:fbillstatus].lstrip.rstrip=="审核")
      #审核操作更新审核人、审核日期
      @assettype[0].update(Approver: session[:name],ApproverDate: Time.now.strftime("%Y-%m-%d %H:%M:%S"))  
    end  
    message=params[:fbillstatus].to_s + "成功！"
  end   
      render :json  => {code: 200,message: message}
end 
end



 
#选择基础资料
  def choose   
    assettype = Assettype.find(params[:assettypeid]) 
    @name = assettype.Name
    @id=   params[:id] 
    render 'choose/choose.js.erb'
  end


#忽略
  def export_all 
    @assettype_all =Assettype.all; 
  end

#保存
  def save_all
    if params["id"]==""  
      #新建
      @assettype = Assettype.create!(Assettypecode: params[:Assettypecode],Name:params[:Name],ParentAssettype:params[:ParentAssettype],Level:params[:Level],Orgainize_id:params[:Orgainize_id],fbillstatus:"未审核",Creator:session[:name],CreateDate:Time.now.strftime("%Y-%m-%d %H:%M:%S") )
    else
      #修改
      @assettype = Assettype.update(Assettypecode: params[:Assettypecode],Name:params[:Name],ParentAssettype:params[:ParentAssettype],Level:params[:Level],Orgainize_id:params[:Orgainize_id])
    end

    render :json  => {code: 200, message: "资产类别保存成功！",id:@assettype.id }
  end
#忽略
  def save_multiple  
    params["assettypeid"].each do |i|  
      assettype = Assettype.create!(Assettypecode: i[1][0],Name: i[1][1],Orgainize_id: i[1][2],description: i[1][3])
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
    params["assettype_id"].each do |i| 
      #删除检验
      result=Delete_Check("资产类型",i);     
      if(result=="")
        #检验通过，成功数+1，删除资产类型
        sussess+=1;
        Assettype.destroy(i)
      else
        #检验不通过，失败数+1
        error+=1;
        message=message+result  
      end 
  end 
  message="删除成功数：#{sussess}\n"+"删除失败数：#{error}\n"+message;
  render :json  => {code: 200,message: message }
end


 


  # GET /assettypes
  # GET /assettypes.json
  #忽略
  def index 
    @q = Assettype.search(params[:q])       
    if  params[:q].nil? 
      @assettypes=Assettype.order(:id).page(params[:page]).per(10)
    else 
      if  params[:q]["name_cont"].lstrip.rstrip==""
        @assettypes=Assettype.order(:id).page(params[:page]).per(10)
      else
        search = params[:q]["search_cont"]
        @assettypes  = Assettype.where( " #{search}  like  ?",  "%#{params[:q]["name_cont"]}%" ) .page(params[:page]).per(10)
      end
    end  

    @department=Department.all
  end

  # GET /assettypes/1
  # GET /assettypes/1.json
  def show
  end

  # GET /assettypes/new
  def new
    @assettype = Assettype.new
    if (params.include? 'ParentAssettype') 
      #2021/3/20 阿斌修改，新增时，增加检验，非审核状态不允许作为上级资产卡片 
      if(params[:ParentAssettype].lstrip.rstrip=="资产类型-列表")
        #新增资产类别时，如果选择的是资产类型-列表，则等级等于第一级
        @assettype.Level=1
      else
        #新增资产类别时，上级资产类别等于所选资产类别，等级等于所选资产类别等级+1
        @assettype_by_ParentAssettype=Assettype.where("Name='#{params[:ParentAssettype]}'") 
        @assettype.Level=@assettype_by_ParentAssettype[0].Level.to_i+1
        @assettype.ParentAssettype=params[:ParentAssettype]
      end 
    end
    #单据状态为未审核
    @assettype.fbillstatus="未审核"
  end

  # GET /assettypes/1/edit
  def edit
  end

  # POST /assettypes
  # POST /assettypes.json
  def create
    @assettype = Assettype.new(Assettypecode: params[:Assettypecode],Name:params[:Name],ParentAssettype:params[:ParentAssettype],Level:params[:Level],Orgainize_id:params[:Orgainize_id] ) 
    @assettype.Creator=session[:name] 
    @assettype.CreateDate=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @assettype.fbillstatus="未审核"
    respond_to do |format|
      if @assettype.save
        render :json  => {code: 200,message: "资产类别创建成功！" }
      else
        format.html { render :new }
        format.json { render json: @assettype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assettypes/1
  # PATCH/PUT /assettypes/1.json
  def update
    respond_to do |format|
      if @assettype.update(assettype_params)
        format.html { redirect_to @assettype, notice: '修改成功！' }
        format.json { render :show, status: :ok, location: @assettype }
      else
        format.html { render :edit }
        format.json { render json: @assettype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assettypes/1
  # DELETE /assettypes/1.json
  def destroy
    @assettype.destroy
    respond_to do |format|
      format.html { redirect_to assettypes_url, notice: '删除成功！' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assettype
      @assettype = Assettype.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assettype_params
      params.require(:assettype).permit(:Assettypecode, :Name, :Orgainize_id, :description,:fbillstatus,:Creator,:CreateDate,:Approver,:ApproverDate,:ParentAssettype,:Level)
    end
end
