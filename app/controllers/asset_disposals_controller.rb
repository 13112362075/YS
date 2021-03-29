class AssetDisposalsController < ApplicationController
  before_action :set_asset_disposal, only: [:show, :edit, :update, :destroy]

  #更新状态
  def Update_fbillstatus  
    #返回信息
    message=""
    #事务
    ActiveRecord::Base.transaction do 
      @assetDisposal=AssetDisposal.find(params[:id]) 
      if params[:fbillstatus]=="审核"
        @Fbillstatus="已审核"
      else
        @Fbillstatus="未审核"
      end 
      #更新状态检验
      message=message+ Update_Fbillstatus_Check("资产处置单",params[:id],params[:fbillstatus]).to_s  
      if  message.lstrip.rstrip==""
        #检验通过
        @assetDisposal.update(Fbillstatus:@Fbillstatus)
        if(params[:fbillstatus]=="审核")
          #审核操作更新审核人、审核日期
          @assetDisposal.update(Approver: session[:name],ApproveDate: Time.now.strftime("%Y-%m-%d %H:%M:%S"))
        end
        #更新资产卡片数据
        Update_datas("资产处置单",params,"");  
        message=params[:fbillstatus].to_s + "成功！"
      end 
    end 
      render :json  => {code: 200,message: message,id: @id}
  end

 #批量删除
  def destroy_multiple     
    #事务
    ActiveRecord::Base.transaction do
      message="";
      params["asset_disposalsid"].each do |i|  
        #删除检验
        message =message +  Delete_Check("资产处置单",i ).to_s
        if message.lstrip.rstrip =="" 
          #检验通过
          @Entry_by_Asset_recovery_id  = AssetDisposalEntry.where( "AssetDisposal_id =  ?",  "#{i}")
          @Entry_by_Asset_recovery_id.each do |id|
            @AssetDisposalEntry_1 = AssetDisposalEntry.find(id.id)  
            @AssetDisposalEntry_1.destroy
          end 
          AssetDisposal.destroy(i) 
        end
      end 
      if message.lstrip.rstrip!=""
        #检验不通过，事务回滚！
        render :json  => {code: 201,message: message }
        raise ActiveRecord::Rollback 
      else
        render :json  => {code: 200,message: "删除成功！" }
      end
    end
  end



#返回Json数据
  def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
    render json:{code: code, msg: message, count: count,data: data};
  end

#获取接口数据
  def Get_DataApi
    #获取单据数据
    assetDisposal=AssetDisposal.order(:id);
    #获取单据数据数量
    total_count=assetDisposal.count
    #分页
    assetDisposal=assetDisposal.page(params[:page]).per(params[:limit])
    #转换成Json数据
    data=assetDisposal.as_json;
    #返回Json数据
    api_success(count: total_count,data: data)
  end



#保存
def save_all
  #返回信息
  message=""   
  #事务
  ActiveRecord::Base.transaction do
    @id=0;
    if params["id"]==""  
      #保存单据
      #单据头检验
      message = message + Save_Check("资产处置单",params).to_s
      if message.lstrip.rstrip=="" 
        #检验通过，创建单据头
        @AssetDisposal = AssetDisposal.create!(FBillno:params["FBillno"],DisposeDate: params["DisposeDate"],Disposemethod: params["Disposemethod"],DisposeReason: params["DisposeReason"],Creator: session[:name],Fbillstatus: '未审核', CreateDate: Time.now.strftime("%Y-%m-%d %H:%M:%S"));
        @id=@AssetDisposal.id
        index =0; 
        params["datas"].each do |i|  
          index+=1;
          #单据体检验
          message=message+Save_Check_Entry("资产处置单",params,i,index)  
          #单据体保存
          @AssetDisposalEntry = AssetDisposalEntry.create!(Code: i[1][0],name: i[1][1],Unit: i[1][2],Amount: i[1][3],DisposeAmount: i[1][4],Asset_seat: i[1][5],DisposePrice: i[1][6],Usestate_id: i[1][8],AssetDisposal_id: @id,fseq: i[1][10],Addtype_id: i[1][7]);
        end
      end
    else
      @id=params["id"];  
      #单据修改保存
      #单据头保存检验
      message = message + Save_Check("资产处置单",params ).to_s  
      @AssetDisposal= AssetDisposal.find_by(id: @id) 
      if message.lstrip.rstrip=="" 
        #检验通过，更新单据头
        @AssetDisposal.update(FBillno:params["FBillno"],DisposeDate: params["DisposeDate"],Disposemethod: params["Disposemethod"],DisposeReason: params["DisposeReason"]);
        @AssetDisposalEntry1  = AssetDisposalEntry.where( "AssetDisposal_id =  ?",   @id)
        @AssetDisposalEntry1.each do  |id| 
          if  !params[:array_id].to_a.include?(id.id.to_s)
            #相对应比上次的单据体记录，不存在则删除
            @AssetDisposalEntry_1 = AssetDisposalEntry.find(id.id) 
            @assetcard=Assetcard.where("Code =  ?",  @AssetDisposalEntry_1. Code)#2021-1-14 阿斌修改，删除的过程中，修改状态
            #@assetcard.update(Usestate_id: "可用")#2021-1-14 阿斌修改，删除的过程中，修改状态  
            @AssetDisposalEntry_1.destroy
          end
        end
        index =0;
        params[:datas].each do  |i|
          index+=1;
          #单据体保存检验
          message=message+ Save_Check_Entry("资产处置单",params,i,index) 
          if  i[1][9].to_s == "0"
            #相对比保存之前的单据体，新建单据体
            @AssetDisposalEntry_3 = AssetDisposalEntry.create!(Code: i[1][0],name: i[1][1],Unit: i[1][2],Amount: i[1][3],DisposeAmount: i[1][4],Asset_seat: i[1][5],DisposePrice: i[1][6],Usestate_id: i[1][8],AssetDisposal_id: @id,fseq: i[1][10],Addtype_id: i[1][7]);
          else  
            #相对比保存之前的单据体，更新单据体
            @AssetDisposalEntry_2= AssetDisposalEntry.find(i[1][9])  
            @AssetDisposalEntry_2.update(Code: i[1][0],name: i[1][1],Unit: i[1][2],Amount: i[1][3],DisposeAmount: i[1][4],Asset_seat: i[1][5],DisposePrice: i[1][6],Usestate_id: i[1][8],AssetDisposal_id: @id,fseq: i[1][10],Addtype_id: i[1][7]);
          end
        end
      end
    end
    if(message.lstrip.rstrip!="")  
      #保存检验不通过，事务回滚！
      render :json  => {code: 202,message: message }
      raise ActiveRecord::Rollback 
    else
      render :json  => {code: 200,message: "保存成功！",id: @id}
    end
  end 
end


  # GET /asset_disposals
  # GET /asset_disposals.json
  def index
    @asset_disposals = AssetDisposal.all
  end

  # GET /asset_disposals/1
  # GET /asset_disposals/1.json
  def show
  end
 
  # GET /asset_disposals/new
  def new
    #创建单据时，设置单据状态默认为未审核，单据日期为当天，变动方式为报废
    @asset_disposal = AssetDisposal.new
    @asset_disposal.Disposemethod="报废"
    @asset_disposal.Fbillstatus="未审核"
    @assetcard  =  Assetcard.where(" fbillstatus ='已审核'  ");     
    @asset_disposal.DisposeDate=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @addtype = Addtype.all   
  end

  # GET /asset_disposals/1/edit
  def edit
    @asset_disposal_entry  = AssetDisposalEntry.where( "AssetDisposal_id =  ?",  "#{params[:id]}" )   
    @addtype = Addtype.all   
    @assetcard  =  Assetcard.where(" fbillstatus ='已审核' ");    
  end

  # POST /asset_disposals
  # POST /asset_disposals.json
  def create
    @asset_disposal = AssetDisposal.new(asset_disposal_params) 
    respond_to do |format|
      if @asset_disposal.save
        format.html { redirect_to @asset_disposal, notice: 'Asset disposal was successfully created.' }
        format.json { render :show, status: :created, location: @asset_disposal }
      else
        format.html { render :new }
        format.json { render json: @asset_disposal.errors, status: :unprocessable_entity }
      end.lstrip
    end
  end

  # PATCH/PUT /asset_disposals/1
  # PATCH/PUT /asset_disposals/1.json
  def update
    respond_to do |format|
      if @asset_disposal.update(asset_disposal_params)
        format.html { redirect_to @asset_disposal, notice: 'Asset disposal was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_disposal }
      else
        format.html { render :edit }
        format.json { render json: @asset_disposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_disposals/1
  # DELETE /asset_disposals/1.json
  def destroy
    @asset_disposal.destroy
    respond_to do |format|
      format.html { redirect_to asset_disposals_url, notice: 'Asset disposal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_disposal
      @asset_disposal = AssetDisposal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_disposal_params
      params.require(:asset_disposal).permit(:FBillno, :DisposeDate, :Disposemethod, :DisposeReason, :Fbillstatus, :Creator, :Approver, :CreateDate, :ApproveDate)
    end
end
