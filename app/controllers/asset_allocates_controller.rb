class AssetAllocatesController < ApplicationController
  before_action :set_asset_allocate, only: [:show, :edit, :update, :destroy]

  #批量删除
  def destroy_multiple     
    #事务
    ActiveRecord::Base.transaction do
      #返回信息
      message="";
      #根据单据id循环
      params["asset_allocatesid"].each do |i|  
        #删除检验
        message =message +  Delete_Check("资产调拨单",i ).to_s
        if message.lstrip.rstrip =="" 
          #删除检验通过，删除单据头
          @Entry_by_Asset_Allocate_id  = AssetAllocateEntry.where( "Asset_Allocate_id =  ?",  "#{i}")
          #删除所对应的单据体id
          @Entry_by_Asset_Allocate_id.each do |id|
            @AssetAllocate_1 = AssetAllocateEntry.find(id.id)  
            @AssetAllocate_1.destroy
          end 
          #删除单据头
          AssetAllocate.destroy(i) 
        end
      end
   
      if message.lstrip.rstrip!=""
        #删除检验不通过，返回删除失败信息
        render :json  => {code: 201,message: message }
        raise ActiveRecord::Rollback 
      else
        #删除检验通过，返回删除成功信息
        render :json  => {code: 200,message: "删除成功！" }
      end
    end
  end


#返回Json数据
  def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
    render json:{code: code, msg: message, count: count,data: data};
  end

#构建Api接口
  def Get_DataApi
    #返回所有单据信息
    assetAllocate = AssetAllocate.order(:id);
    #返回单据总数量
    total_count=assetAllocate.count
    #分页
    assetAllocate=assetAllocate.page(params[:page]).per(params[:limit])
    #转换Json数据
    data=assetAllocate.as_json;
    #返回Json数据
    api_success(count: total_count,data: data)
  end



#根据数据状态
  def Update_fbillstatus
    #返回信息
    message=""
    #事务
    ActiveRecord::Base.transaction do 
      @AssetAllocate=AssetAllocate.find(params[:id]) 
      if params[:fbillstatus]=="审核"
        @Fbillstatus="已审核"
      else
        @Fbillstatus="未审核"
      end 
      #修改状态检验
      message=message+ Update_Fbillstatus_Check("资产调拨单",params[:id],params[:fbillstatus]).to_s   
      if  message.lstrip.rstrip==""
        #检验通过，更新单据状态
        @AssetAllocate.update(FBillstatus:@Fbillstatus)
        #审核操作，则更新审核人和审核日期
        if(params[:fbillstatus].lstrip.rstrip=="审核")
          @AssetAllocate.update(Approver: session[:name],APPROVEDATE: Time.now.strftime("%Y-%m-%d %H:%M:%S"))  
        end 
        #更新资产卡片数据
        Update_datas("资产调拨单",params,"");  
        message=params[:fbillstatus].to_s + "成功！"
      end  
    end 
      render :json  => {code: 200,message: message,id: @id}
  end


#保存
def save_all
  #返回信息
  message=""   
  #事务
  ActiveRecord::Base.transaction do
    @id=0;
    #判断单据是否为新建
    if params["id"]==""  
      #单据创建
      #单据头保存检验
      message = message + Save_Check("资产调拨单",params).to_s
      if message.lstrip.rstrip=="" 
        #检验通过，则创建单据头
        @AssetAllocate = AssetAllocate.create!( FBillno:params["FBillno"],Expdate: params["Expdate"],Allocate_reason: params["Allocate_reason"],Creator: session[:name],FBillstatus: '未审核', CREATEDATE: Time.now.strftime("%Y-%m-%d %H:%M:%S"));
        #返回单据头id
        @id=@AssetAllocate.id
        index =0; 
        params["datas"].each do |i|  
          index+=1;
          #单据体检验
          message=message+Save_Check_Entry("资产调拨单",params,i,index)  
          #创建单据体
          @AssetAllocateEntry = AssetAllocateEntry.create!(Code: i[1][0],name: i[1][1],Unit: i[1][2],Model: i[1][3],Amount: i[1][4],EXPdept: i[1][5],Employeeld: i[1][6] ,Asset_seat:i[1][7] ,EXPQTY: i[1][8],IMPdept: i[1][9],Newuser: i[1][10],IMP_seat: i[1][11],fseq: i[1][13],Asset_allocate_id: @id);
        end
      end
    else

      @id=params["id"];  
      #单据修改
      #单据头保存检验
      message = message + Save_Check("资产调拨单",params ).to_s 
      @AssetAllocate= AssetAllocate.find_by(id: @id) 
      if message.lstrip.rstrip=="" 
        #单据头检验通过
        #单据头保存修改
        @AssetAllocate.update(FBillno:params["FBillno"],Expdate: params["Expdate"],Allocate_reason: params["Allocate_reason"] );
        @AssetAllocateEntry1  = AssetAllocateEntry.where( "Asset_Allocate_id =  ?",   @id)
        @AssetAllocateEntry1.each do  |id| 
          #单据体保存，删除保存之前的记录
          if  !params[:array_id].to_a.include?(id.id.to_s)
            @AssetAllocateEntry_1 = AssetAllocateEntry.find(id.id) 
            @assetcard=Assetcard.where("Code =  ?",  @AssetAllocateEntry_1. Code)#2021-1-14 阿斌修改，删除的过程中，修改状态
            #@assetcard.update(Usestate_id: "可用")#2021-1-14 阿斌修改，删除的过程中，修改状态  
            @AssetAllocateEntry_1.destroy
          end
        end
        index =0;
        params[:datas].each do  |i|
          index+=1;
          #单据体保存检验
          message=message+ Save_Check_Entry("资产调拨单",params,i,index) 
          if  i[1][12].to_s == "0" 
            #创建单据体，相对比上次保存新增的单据体记录
            @AssetAllocateEntry_3 = AssetAllocateEntry.create!(Code: i[1][0],name: i[1][1],Unit: i[1][2],Model: i[1][3],Amount: i[1][4],EXPdept: i[1][5],Employeeld: i[1][6] ,Asset_seat:i[1][7] ,EXPQTY: i[1][8],IMPdept: i[1][9],Newuser: i[1][10],IMP_seat: i[1][11],fseq: i[1][13],Asset_allocate_id: @id);
          else  
            #更新单据体，相对比上次保存新增的单据体记录
            @AssetAllocateEntry_2= AssetAllocateEntry.find(i[1][12])  
            @AssetAllocateEntry_2.update(Code: i[1][0],name: i[1][1],Unit: i[1][2],Model: i[1][3],Amount: i[1][4],EXPdept: i[1][5],Employeeld: i[1][6] ,Asset_seat:i[1][7] ,EXPQTY: i[1][8],IMPdept: i[1][9],Newuser: i[1][10],IMP_seat: i[1][11],fseq: i[1][13] );
          end
        end
      end
    end
    if(message.lstrip.rstrip!="")  
      #保存检验不通过，事务回滚，返回保存失败原因
      render :json  => {code: 202,message: message }
      raise ActiveRecord::Rollback 
    else
      #保存成功！
      render :json  => {code: 200,message: "保存成功！",id: @id}
    end
  end 
end


  # GET /asset_allocates
  # GET /asset_allocates.json
  def index
    @asset_allocates = AssetAllocate.all
  end

  # GET /asset_allocates/1
  # GET /asset_allocates/1.json
  def show
  end

  # GET /asset_allocates/new
  def new
    #新增单据，单据状态默认为未审核，单据日期默认为当前日期
    @asset_allocate = AssetAllocate.new 
    @asset_allocate.FBillstatus="未审核"
    @asset_allocate.Expdate=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @assetcard  =  Assetcard.where("Usestate_id='可用'  and fbillstatus='已审核' ");   
    @user = User.all   
    @department = Department.all      
    @assetseate = Assetseate.all   
  end

  # GET /asset_allocates/1/edit
  def edit
    @asset_allocate_entry  = AssetAllocateEntry.where( "Asset_allocate_id =  ?",  "#{params[:id]}" )    
    @assetcard  =  Assetcard.where("Usestate_id='可用'  and fbillstatus='已审核' ");   
    @user = User.all   
    @department = Department.all      
    @assetseate = Assetseate.all   
  end

  # POST /asset_allocates
  # POST /asset_allocates.json
  def create
    @asset_allocate = AssetAllocate.new(asset_allocate_params)

    respond_to do |format|
      if @asset_allocate.save
        format.html { redirect_to @asset_allocate, notice: 'Asset allocate was successfully created.' }
        format.json { render :show, status: :created, location: @asset_allocate }
      else
        format.html { render :new }
        format.json { render json: @asset_allocate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_allocates/1
  # PATCH/PUT /asset_allocates/1.json
  def update
    respond_to do |format|
      if @asset_allocate.update(asset_allocate_params)
        format.html { redirect_to @asset_allocate, notice: 'Asset allocate was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_allocate }
      else
        format.html { render :edit }
        format.json { render json: @asset_allocate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_allocates/1
  # DELETE /asset_allocates/1.json
  def destroy
    @asset_allocate.destroy
    respond_to do |format|
      format.html { redirect_to asset_allocates_url, notice: 'Asset allocate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_allocate
      @asset_allocate = AssetAllocate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_allocate_params
      params.require(:asset_allocate).permit(:FBillno, :Expdate, :Allocate_reason, :FBillstatus, :Creator, :Approver, :CREATEDATE, :APPROVEDATE)
    end
end
