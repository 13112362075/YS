class AssetDisposalsController < ApplicationController
  before_action :set_asset_disposal, only: [:show, :edit, :update, :destroy]

  def Update_fbillstatus  
    message=""
    ActiveRecord::Base.transaction do 
      @assetDisposal=AssetDisposal.find(params[:id]) 
      if params[:fbillstatus]=="审核"
        @Fbillstatus="已审核"
      else
        @Fbillstatus="未审核"
      end 
      message=message+ Update_Fbillstatus_Check("资产处置单",params[:id],params[:fbillstatus]).to_s  
      if  message.lstrip.rstrip==""
        @assetDisposal.update(Fbillstatus:@Fbillstatus)
        if(params[:fbillstatus]=="审核")
          @assetDisposal.update(Approver: session[:name],ApproveDate: Time.now.strftime("%Y-%m-%d %H:%M:%S"))
        end
        message=params[:fbillstatus].to_s + "成功！"
      end 
    end 
      render :json  => {code: 200,message: message,id: @id}
  end

 
  def destroy_multiple     
    ActiveRecord::Base.transaction do
      message="";
      params["asset_disposalsid"].each do |i|  
        message =message +  Delete_Check("资产处置单",i ).to_s
        if message.lstrip.rstrip =="" 
          @Entry_by_Asset_recovery_id  = AssetDisposalEntry.where( "AssetDisposal_id =  ?",  "#{i}")
          @Entry_by_Asset_recovery_id.each do |id|
            @AssetDisposalEntry_1 = AssetDisposalEntry.find(id.id)  
            @AssetDisposalEntry_1.destroy
          end 
          AssetDisposal.destroy(i) 
        end
      end
   
      if message.lstrip.rstrip!=""
        render :json  => {code: 201,message: message }
        raise ActiveRecord::Rollback 
      else
        render :json  => {code: 200,message: "删除成功！" }
      end
    end
  end




  def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
    render json:{code: code, msg: message, count: count,data: data};
  end


  def Get_DataApi
    assetDisposal=AssetDisposal.order(:id);
    total_count=assetDisposal.count
    assetDisposal=assetDisposal.page(params[:page]).per(params[:limit])
    data=assetDisposal.as_json;
    api_success(count: total_count,data: data)
  end




def save_all
  message=""   
  ActiveRecord::Base.transaction do
    @id=0;
    if params["id"]==""  
      message = message + Save_Check("资产处置单",params).to_s
      if message.lstrip.rstrip=="" 
        @AssetDisposal = AssetDisposal.create!(FBillno:params["FBillno"],DisposeDate: params["DisposeDate"],Disposemethod: params["Disposemethod"],DisposeReason: params["DisposeReason"],Creator: session[:name],Fbillstatus: '未审核', CreateDate: Time.now.strftime("%Y-%m-%d %H:%M:%S"));
        @id=@AssetDisposal.id
        index =0; 
        params["datas"].each do |i| 
          index+=1;
          message=message+Save_Check_Entry("资产处置单",params,i,index)  
          @AssetDisposalEntry = AssetDisposalEntry.create!(Code: i[1][0],name: i[1][1],Unit: i[1][2],Amount: i[1][3],DisposeAmount: i[1][4],Asset_seat: i[1][5],DisposePrice: i[1][6] ,AssetDisposal_id: @id,fseq: i[1][9],Addtype_id: i[1][7]);
        end
      end
    else
      @id=params["id"];  
      message = message + Save_Check("资产处置单",params ).to_s 
      @AssetDisposal= AssetDisposal.find_by(id: @id) 
      if message.lstrip.rstrip=="" 
        @AssetDisposal.update(FBillno:params["FBillno"],DisposeDate: params["DisposeDate"],Disposemethod: params["Disposemethod"],DisposeReason: params["DisposeReason"]);
        @AssetDisposalEntry1  = AssetDisposalEntry.where( "AssetDisposal_id =  ?",   @id)
        @AssetDisposalEntry1.each do  |id| 
          if  !params[:array_id].to_a.include?(id.id.to_s)
            @AssetDisposalEntry_1 = AssetDisposalEntry.find(id.id) 
            @assetcard=Assetcard.where("Code =  ?",  @AssetDisposalEntry_1. Code)#2021-1-14 阿斌修改，删除的过程中，修改状态
            #@assetcard.update(Usestate_id: "可用")#2021-1-14 阿斌修改，删除的过程中，修改状态  
            @AssetDisposalEntry_1.destroy
          end
        end
        index =0;
        params[:datas].each do  |i|
          index+=1;
          message=message+ Save_Check_Entry("资产处置单",params,i,index) 
          if  i[1][8].to_s == "0"
            @AssetDisposalEntry_3 = AssetDisposalEntry.create!(Code: i[1][0],name: i[1][1],Unit: i[1][2],Amount: i[1][3],DisposeAmount: i[1][4],Asset_seat: i[1][5],DisposePrice: i[1][6] ,AssetDisposal_id: @id,fseq: i[1][9],Addtype_id: i[1][7]);
          else  
            @AssetDisposalEntry_2= AssetDisposalEntry.find(i[1][8])  
            @AssetDisposalEntry_2.update(Code: i[1][0],name: i[1][1],Unit: i[1][2],Amount: i[1][3],DisposeAmount: i[1][4],Asset_seat: i[1][5],DisposePrice: i[1][6] ,AssetDisposal_id: @id,fseq: i[1][9],Addtype_id: i[1][7]);
          end
        end
      end
    end
    if(message.lstrip.rstrip!="")  
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
    @asset_disposal = AssetDisposal.new
    @asset_disposal.Disposemethod="报废"
    @asset_disposal.Fbillstatus="未审核"
    @assetcard  =  Assetcard.where(" fbillstatus ='已审核' ");    
    @user = User.all   
    @addtype = Addtype.all   
    @department = Department.all      
    @asset_disposal.DisposeDate=Time.now.strftime("%Y-%m-%d %H:%M:%S")
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
      end
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
