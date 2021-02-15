class AssetAllocatesController < ApplicationController
  before_action :set_asset_allocate, only: [:show, :edit, :update, :destroy]

  def destroy_multiple     
    ActiveRecord::Base.transaction do
      message="";
      params["asset_allocatesid"].each do |i|  
        message =message +  Delete_Check("资产调拨单",i ).to_s
        if message.lstrip.rstrip =="" 
          @Entry_by_Asset_Allocate_id  = AssetAllocateEntry.where( "Asset_Allocate_id =  ?",  "#{i}")
          @Entry_by_Asset_Allocate_id.each do |id|
            @AssetAllocate_1 = AssetAllocateEntry.find(id.id)  
            @AssetAllocate_1.destroy
          end 
          AssetAllocate.destroy(i) 
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
    assetAllocate = AssetAllocate.order(:id);
    total_count=assetAllocate.count
    assetAllocate=assetAllocate.page(params[:page]).per(params[:limit])
    data=assetAllocate.as_json;
    api_success(count: total_count,data: data)
  end




  def Update_fbillstatus  
    message=""
    ActiveRecord::Base.transaction do

      @AssetAllocate=AssetAllocate.find(params[:id]) 
      if params[:fbillstatus]=="审核"
        @Fbillstatus="已审核"
      else
        @Fbillstatus="未审核"
      end 
      message=message+ Update_Fbillstatus_Check("资产调拨单",params[:id],params[:fbillstatus]).to_s  
      if  message.lstrip.rstrip==""
        @AssetAllocate.update(FBillstatus:@Fbillstatus)
        if(params[:fbillstatus]=="审核")
          @AssetAllocate.update(Approver: session[:name],APPROVEDATE: Time.now.strftime("%Y-%m-%d %H:%M:%S"))
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
      message = message + Save_Check("资产调拨单",params).to_s
      if message.lstrip.rstrip=="" 
        @AssetAllocate = AssetAllocate.create!( FBillno:params["FBillno"],Expdate: params["Expdate"],Allocate_reason: params["Allocate_reason"],Creator: session[:name],FBillstatus: '未审核', CREATEDATE: Time.now.strftime("%Y-%m-%d %H:%M:%S"));
        @id=@AssetAllocate.id
        index =0; 
        params["datas"].each do |i| 
          index+=1;
          message=message+Save_Check_Entry("资产调拨单",params,i,index)  
          @AssetAllocateEntry = AssetAllocateEntry.create!(Code: i[1][0],name: i[1][1],Unit: i[1][2],Model: i[1][3],Amount: i[1][4],EXPdept: i[1][5],Employeeld: i[1][6] ,Asset_seat:i[1][7] ,EXPQTY: i[1][8],IMPdept: i[1][9],Newuser: i[1][10],IMP_seat: i[1][11],fseq: i[1][13],Asset_allocate_id: @id);
        end
      end
    else
      @id=params["id"];  
      message = message + Save_Check("资产调拨单",params ).to_s 
      @AssetAllocate= AssetAllocate.find_by(id: @id) 
      if message.lstrip.rstrip=="" 
        @AssetAllocate.update(FBillno:params["FBillno"],Expdate: params["Expdate"],Allocate_reason: params["Allocate_reason"] );
        @AssetAllocateEntry1  = AssetAllocateEntry.where( "Asset_Allocate_id =  ?",   @id)
        @AssetAllocateEntry1.each do  |id| 
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
          message=message+ Save_Check_Entry("资产调拨单",params,i,index) 
          if  i[1][12].to_s == "0" 
            @AssetAllocateEntry_3 = AssetAllocateEntry.create!(Code: i[1][0],name: i[1][1],Unit: i[1][2],Model: i[1][3],Amount: i[1][4],EXPdept: i[1][5],Employeeld: i[1][6] ,Asset_seat:i[1][7] ,EXPQTY: i[1][8],IMPdept: i[1][9],Newuser: i[1][10],IMP_seat: i[1][11],fseq: i[1][13],Asset_allocate_id: @id);
          else  
            @AssetAllocateEntry_2= AssetAllocateEntry.find(i[1][12])  
            @AssetAllocateEntry_2.update(Code: i[1][0],name: i[1][1],Unit: i[1][2],Model: i[1][3],Amount: i[1][4],EXPdept: i[1][5],Employeeld: i[1][6] ,Asset_seat:i[1][7] ,EXPQTY: i[1][8],IMPdept: i[1][9],Newuser: i[1][10],IMP_seat: i[1][11],fseq: i[1][13] );
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
    @asset_allocate = AssetAllocate.new 
    @asset_allocate.FBillstatus="未审核"
    @assetcard  =  Assetcard.where("Usestate_id='可用'");   
  end

  # GET /asset_allocates/1/edit
  def edit
    @asset_allocate_entry  = AssetAllocateEntry.where( "Asset_allocate_id =  ?",  "#{params[:id]}" )    
    @assetcard  =  Assetcard.where("Usestate_id='可用'");    
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
