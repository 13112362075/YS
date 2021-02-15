class AssetLossesController < ApplicationController
  before_action :set_asset_loss, only: [:show, :edit, :update, :destroy]


  def destroy_multiple     
    ActiveRecord::Base.transaction do
      message="";
      params["asset_lossesid"].each do |i|  
        message =message +  Delete_Check("资产盘亏单",i ).to_s
        if message.lstrip.rstrip =="" 
          @Entry_Asset_Loss_id  = AssetLossEntry.where( "Asset_Loss_id =  ?",  "#{i}")
          @Entry_Asset_Loss_id.each do |id|
            @AssetLossEntry = AssetLossEntry.find(id.id)  
            @AssetLossEntry.destroy
          end 
          AssetLoss.destroy(i) 
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
    assetLoss=AssetLoss.order(:id);
    total_count=assetLoss.count
    assetLoss=assetLoss.page(params[:page]).per(params[:limit])
    data=assetLoss.as_json;
    api_success(count: total_count,data: data)
  end



  def Update_fbillstatus  
    message=""
    ActiveRecord::Base.transaction do 
      @AssetLoss=AssetLoss.find(params[:id]) 
      if params[:fbillstatus]=="审核"
        @Fbillstatus="已审核"
      else
        @Fbillstatus="未审核"
      end 
      message=message+ Update_Fbillstatus_Check("资产盘亏单",params[:id],params[:fbillstatus]).to_s  
      if  message.lstrip.rstrip==""
        @AssetLoss.update(fbillstatus:@Fbillstatus)
        if(params[:fbillstatus]=="审核")
          @AssetLoss.update(Approver: session[:name],APPROVEDATE: Time.now.strftime("%Y-%m-%d %H:%M:%S"))
        end
        message=params[:fbillstatus].to_s + "成功！"
      end 
    end 
      render :json  => {code: 200,message: message,id: @id}
  end



  def save_all
    message=""   
    ActiveRecord::Base.transaction do
      @id=0;
      if params["id"]==""  
        message = message + Save_Check("资产盘亏单",params).to_s
        if message.lstrip.rstrip==""   
          @AssetLoss = AssetLoss.create!(BillNo:params["BillNo"],description: params["description"],fdate: params["fdate"],Creator: session[:name],fbillstatus: '未审核', CREATEDATE: Time.now.strftime("%Y-%m-%d %H:%M:%S"));
          @id=@AssetLoss.id
          index =0; 
          params["datas"].each do |i| 
            index+=1;
            message=message+Save_Check_Entry("资产盘亏单",params,i,index)    
             
            @AssetLossEntry = AssetLossEntry.create!(Code: i[1][0],name: i[1][1],Asset_type: i[1][2],Unit: i[1][3],BookQty: i[1][4] ,
              CountQty: i[1][5],LossQty: i[1][6],Book_seat: i[1][7],Book_dept:i[1][8],Book_User:i[1][9],Actual_seat:i[1][10],Actual_dept:i[1][11],Actual_User:i[1][12],FSrcFbillno:i[1][13],
              FSrcFseq:i[1][14],fseq:i[1][16],Asset_Loss_id:@id);
          end
        end
      else
        @id=params["id"];  
        message = message + Save_Check("资产盘亏单",params ).to_s 
        @AssetLoss= AssetLoss.find_by(id: @id) 
        if message.lstrip.rstrip=="" 
          @AssetLoss.update(BillNo:params["BillNo"],description: params["description"],fdate: params["fdate"]);
          @AssetLossEntry1  = AssetLossEntry.where( "Asset_Loss_id =  ?",   @id)
          @AssetLossEntry1.each do  |id| 
            if  !params[:array_id].to_a.include?(id.id.to_s)
              @AssetLossEntry_1 = AssetLossEntry.find(id.id) 
              @assetcard=Assetcard.where("Code =  ?",  @AssetLossEntry_1. Code)#2021-1-14 阿斌修改，删除的过程中，修改状态
              #@assetcard.update(Usestate_id: "可用")#2021-1-14 阿斌修改，删除的过程中，修改状态  
              @AssetLossEntry_1.destroy
            end
          end
          index =0;
          params[:datas].each do  |i|
            index+=1;
            message=message+ Save_Check_Entry("资产盘点单",params,i,index) 
            if  i[1][15].to_s == "0"
              @AssetLossEntry_3 = AssetLossEntry.create!(Code: i[1][0],name: i[1][1],Unit: i[1][2],Amount: i[1][3],DisposeAmount: i[1][4],Asset_seat: i[1][5],DisposePrice: i[1][6] ,AssetLoss_id: @id,fseq: i[1][9],Addtype_id: i[1][7]);
            else  
              @AssetLossEntry_2= AssetLossEntry.find(i[1][15])  
              @AssetLossEntry_2.update(Code: i[1][0],name: i[1][1],Asset_type: i[1][2],Unit: i[1][3],BookQty: i[1][4] ,
                CountQty: i[1][5],LossQty: i[1][6],Book_seat: i[1][7],Book_dept:i[1][8],Book_User:i[1][9],Actual_seat:i[1][10],Actual_dept:i[1][11],Actual_User:i[1][12],FSrcFbillno:i[1][13],
                FSrcFseq:i[1][14],fseq:i[1][16]);
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



  # GET /asset_losses
  # GET /asset_losses.json
  def index
    @asset_losses = AssetLoss.all
  end

  # GET /asset_losses/1
  # GET /asset_losses/1.json
  def show
  end

  # GET /asset_losses/new
  def new
    @asset_loss = AssetLoss.new
    @fseq=0; 
    @asset_loss.fdate=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @asset_loss.fbillstatus="未审核"
    @assetcard  =  Assetcard.where(" fbillstatus ='已审核' ");    
  end

  # GET /asset_losses/1/edit
  def edit 
    @asset_loss_entry  = AssetLossEntry.where( "Asset_Loss_id =  ?",  "#{params[:id]}" )   
    @assetcard  =  Assetcard.where(" fbillstatus ='已审核' ");    
  end

  # POST /asset_losses
  # POST /asset_losses.json
  def create
    @asset_loss = AssetLoss.new(asset_loss_params)

    respond_to do |format|
      if @asset_loss.save
        format.html { redirect_to @asset_loss, notice: 'Asset loss was successfully created.' }
        format.json { render :show, status: :created, location: @asset_loss }
      else
        format.html { render :new }
        format.json { render json: @asset_loss.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_losses/1
  # PATCH/PUT /asset_losses/1.json
  def update
    respond_to do |format|
      if @asset_loss.update(asset_loss_params)
        format.html { redirect_to @asset_loss, notice: 'Asset loss was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_loss }
      else
        format.html { render :edit }
        format.json { render json: @asset_loss.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_losses/1
  # DELETE /asset_losses/1.json
  def destroy
    @asset_loss.destroy
    respond_to do |format|
      format.html { redirect_to asset_losses_url, notice: 'Asset loss was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_loss
      @asset_loss = AssetLoss.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_loss_params
      params.require(:asset_loss).permit(:BillNo, :description, :fdate, :fbillstatus, :Creator, :Approver, :CREATEDATE, :APPROVEDATE)
    end
end
