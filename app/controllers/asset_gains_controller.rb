class AssetGainsController < ApplicationController
  before_action :set_asset_gain, only: [:show, :edit, :update, :destroy] 

  def destroy_multiple     
    ActiveRecord::Base.transaction do
      message="";
      params["asset_gainsid"].each do |i|  
        message =message +  Delete_Check("资产盘盈单",i ).to_s
        if message.lstrip.rstrip =="" 
          @Entry_Asset_Gain_id  = AssetGainEntry.where( "Asset_Gain_id =  ?",  "#{i}")
          @Entry_Asset_Gain_id.each do |id|
            @AssetGainEntry = AssetGainEntry.find(id.id)  
            @AssetGainEntry.destroy
          end 
          AssetGain.destroy(i) 
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
    assetGain=AssetGain.order(:id);
    total_count=assetGain.count
    assetGain=assetGain.page(params[:page]).per(params[:limit])
    data=assetGain.as_json;
    api_success(count: total_count,data: data)
  end



  def Update_fbillstatus  
    message=""
    ActiveRecord::Base.transaction do 
      @AssetGain=AssetGain.find(params[:id]) 
      if params[:fbillstatus]=="审核"
        @Fbillstatus="已审核"
      else
        @Fbillstatus="未审核"
      end 
      message=message+ Update_Fbillstatus_Check("资产盘盈单",params[:id],params[:fbillstatus]).to_s  
      if  message.lstrip.rstrip==""
        @AssetGain.update(fbillstatus:@Fbillstatus)
        if(params[:fbillstatus]=="审核")
          @AssetGain.update(Approver: session[:name],APPROVEDATE: Time.now.strftime("%Y-%m-%d %H:%M:%S"))
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
        message = message + Save_Check("资产盘盈单",params).to_s
        if message.lstrip.rstrip==""   
          @AssetGain = AssetGain.create!(BillNo:params["BillNo"],description: params["description"],fdate: params["fdate"],Creator: session[:name],fbillstatus: '未审核', CREATEDATE: Time.now.strftime("%Y-%m-%d %H:%M:%S"));
          @id=@AssetGain.id
          index =0; 
          params["datas"].each do |i| 
            index+=1;
            message=message+Save_Check_Entry("资产盘盈单",params,i,index)    
             
            @AssetGainEntry = AssetGainEntry.create!(Code: i[1][0],name: i[1][1],Asset_type: i[1][2],Unit: i[1][3],BookQty: i[1][4] ,
              CountQty: i[1][5],GainQty: i[1][6],Book_seat: i[1][7],Book_dept:i[1][8],Book_User:i[1][9],Actual_seat:i[1][10],Actual_dept:i[1][11],Actual_User:i[1][12],FSrcFbillno:i[1][13],
              FSrcFseq:i[1][14],fseq:i[1][16],Asset_Gain_id:@id);
          end
        end
      else
        @id=params["id"];  
        message = message + Save_Check("资产盘盈单",params ).to_s 
        @AssetGain= AssetGain.find_by(id: @id) 
        if message.lstrip.rstrip=="" 
          @AssetGain.update(BillNo:params["BillNo"],description: params["description"],fdate: params["fdate"]);
          @AssetGainEntry1  = AssetGainEntry.where( "Asset_Gain_id =  ?",   @id)
          @AssetGainEntry1.each do  |id| 
            if  !params[:array_id].to_a.include?(id.id.to_s)
              @AssetGainEntry_1 = AssetGainEntry.find(id.id) 
              @assetcard=Assetcard.where("Code =  ?",  @AssetGainEntry_1. Code)#2021-1-14 阿斌修改，删除的过程中，修改状态
              #@assetcard.update(Usestate_id: "可用")#2021-1-14 阿斌修改，删除的过程中，修改状态  
              @AssetGainEntry_1.destroy
            end
          end
          index =0;
          params[:datas].each do  |i|
            index+=1;
            message=message+ Save_Check_Entry("资产盘盈单",params,i,index) 
            if  i[1][15].to_s == "0"
              @AssetGainEntry_3 = AssetGainEntry.create!(Code: i[1][0],name: i[1][1],Unit: i[1][2],Amount: i[1][3],DisposeAmount: i[1][4],Asset_seat: i[1][5],DisposePrice: i[1][6] ,AssetGain_id: @id,fseq: i[1][9],Addtype_id: i[1][7]);
            else  
              @AssetGainEntry_2= AssetGainEntry.find(i[1][15])  
              @AssetGainEntry_2.update(Code: i[1][0],name: i[1][1],Asset_type: i[1][2],Unit: i[1][3],BookQty: i[1][4] ,
                CountQty: i[1][5],GainQty: i[1][6],Book_seat: i[1][7],Book_dept:i[1][8],Book_User:i[1][9],Actual_seat:i[1][10],Actual_dept:i[1][11],Actual_User:i[1][12],FSrcFbillno:i[1][13],
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
  

  # GET /asset_gains
  # GET /asset_gains.json
  def index
    @asset_gains = AssetGain.all
  end
 
  # GET /asset_gains/1
  # GET /asset_gains/1.json
  def show
  end

  # GET /asset_gains/new
  def new
    @fseq=0;
    @asset_gain = AssetGain.new
    @asset_gain.fdate=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @asset_gain.fbillstatus="未审核"
    @assetcard  =  Assetcard.where(" fbillstatus ='已审核' ");    
  end

  # GET /asset_gains/1/edit
  def edit 
    @asset_gain_entry  = AssetGainEntry.where( "Asset_Gain_id =  ?",  "#{params[:id]}" )   
    @assetcard  =  Assetcard.where(" fbillstatus ='已审核' ");    
  end

  # POST /asset_gains
  # POST /asset_gains.json
  def create
    @asset_gain = AssetGain.new(asset_gain_params)

    respond_to do |format|
      if @asset_gain.save
        format.html { redirect_to @asset_gain, notice: 'Asset gain was successfully created.' }
        format.json { render :show, status: :created, location: @asset_gain }
      else
        format.html { render :new }
        format.json { render json: @asset_gain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_gains/1
  # PATCH/PUT /asset_gains/1.json
  def update
    respond_to do |format|
      if @asset_gain.update(asset_gain_params)
        format.html { redirect_to @asset_gain, notice: 'Asset gain was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_gain }
      else
        format.html { render :edit }
        format.json { render json: @asset_gain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_gains/1
  # DELETE /asset_gains/1.json
  def destroy
    @asset_gain.destroy
    respond_to do |format|
      format.html { redirect_to asset_gains_url, notice: 'Asset gain was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_gain
      @asset_gain = AssetGain.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_gain_params
      params.require(:asset_gain).permit(:BillNo, :description, :fdate, :fbillstatus, :Creator, :Approver, :CREATEDATE, :APPROVEDATE)
    end
end
