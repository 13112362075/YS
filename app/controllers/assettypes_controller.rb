class AssettypesController < ApplicationController
  before_action :set_assettype, only: [:show, :edit, :update, :destroy]



  
  def api_success(type: 0,code: 0,message:'请求成功', count: '3',data:{}) 
    #type==0 获取资产类别列表
    #type==1 获取资产树状列表
    if type==0
      render json:{type:type,code: code, msg: message, count: count,data: data};
    elsif type==1
      render json:{data: data};
    end
  end
  

  def Get_Data_Tree_Api

    sql="  select '资产类型-列表' as Name,0 as 'id', 0 as 'pid' union all select  A.`Name`,A.id, IFNULL(B.id,0) as 'pid' from assettypes A left join assettypes B ON A.ParentAssettype= B.`Name` "
    @assettype=Assettype.find_by_sql (sql)    
    render 'tree'
   
  
    #api_success(type: 1,data: data)
  end


  def Get_DataApi
    if (params.include? 'key')  
      if params[:key][:Assettype_selected].lstrip.rstrip=="资产类型-列表" 
        sql=" select  * from assettypes  where ParentAssettype is NULL"
      else
        sql=" select  * from assettypes  where ParentAssettype = '#{params[:key][:Assettype_selected]}'"
      end 
      assettype=Assettype.find_by_sql (sql)
      assettype.map{|i| i.id}
      assettype = Assettype.where(:id => assettype) 
    else
      assettype=Assettype.order(:id); 
    end 
    
    total_count=assettype.count
    assettype=assettype.page(params[:page]).per(params[:limit])
    data=assettype.as_json;
    api_success(type: 0,count: total_count,data: data)
  end


  def  Update_fbillstatus 
    message=""
    ActiveRecord::Base.transaction do 
    message=""  
    @assettype=Assettype.find(params[:id]) 
    if params[:fbillstatus].lstrip.rstrip=="审核"
      @Fbillstatus="已审核"
    else
      @Fbillstatus="未审核"
    end 
    message=message+ Update_Fbillstatus_Check("资产类别",params[:id],params[:fbillstatus]).to_s   
    if  message.lstrip.rstrip==""
      @assettype[0].update(fbillstatus:@Fbillstatus)
      if(params[:fbillstatus].lstrip.rstrip=="审核")
        @assettype[0].update(Approver: session[:name],ApproverDate: Time.now.strftime("%Y-%m-%d %H:%M:%S"))  
      end  
      message=params[:fbillstatus].to_s + "成功！"
    end   
        render :json  => {code: 200,message: message}
  end 
end


  def choose   
    assettype = Assettype.find(params[:assettypeid]) 
    @name = assettype.Name
    @id=   params[:id] 
    render 'choose/choose.js.erb'
  end



  def export_all 
    @assettype_all =Assettype.all; 
  end


  def save_all
    if params["id"]==""  
      @assettype = Assettype.create!(Assettypecode: params[:Assettypecode],Name:params[:Name],ParentAssettype:params[:ParentAssettype],Level:params[:Level],Orgainize_id:params[:Orgainize_id],fbillstatus:"未审核",Creator:session[:name],CreateDate:Time.now.strftime("%Y-%m-%d %H:%M:%S") )
    else
      @assettype = Assettype.update(Assettypecode: params[:Assettypecode],Name:params[:Name],ParentAssettype:params[:ParentAssettype],Level:params[:Level],Orgainize_id:params[:Orgainize_id])
    end

    render :json  => {code: 200, message: "资产类别保存成功！",id:@assettype.id }
  end

  def save_multiple  
    params["assettypeid"].each do |i|  
      assettype = Assettype.create!(Assettypecode: i[1][0],Name: i[1][1],Orgainize_id: i[1][2],description: i[1][3])
    end
  end

  def destroy_multiple    
    sussess=0;
    error=0;
    message="";
    params["assettype_id"].each do |i|  
      result=Delete_Check("资产类型",i);    
      if(result=="")
        sussess+=1;
        Assettype.destroy(i)
      else
        error+=1; 
        message=message+result  
      end 
  end
  message="删除成功数：#{sussess}\n"+"删除失败数：#{error}\n"+message;
  render :json  => {code: 200,message: message }
  end
 


  # GET /assettypes
  # GET /assettypes.json
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
      if(params[:ParentAssettype].lstrip.rstrip=="资产类型-列表")
        @assettype.Level=1
      else
        @assettype_by_ParentAssettype=Assettype.where("Name='#{params[:ParentAssettype]}'") 
        @assettype.Level=@assettype_by_ParentAssettype[0].Level.to_i+1
        @assettype.ParentAssettype=params[:ParentAssettype]
      end
      
    end
    
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
