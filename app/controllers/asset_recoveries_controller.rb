class AssetRecoveriesController < ApplicationController
  before_action :set_asset_recovery, only: [:show, :edit, :update, :destroy]



  # POST /asset_turnover_details
  # POST /asset_turnover_details.json
  def  save_all 
    @id=0;
    puts params["id"];
   if params["id"]==""   
       @asset_recovery = AssetRecovery.create!(Documentnumber:params["Documentnumber"],Type_of_business: params["Type_of_business"],Requisition_Date: params["Requisition_Date"]);
       @id=@asset_recovery.id
       params["datas"].each do |i|  
        assetRecoveryEntry = AssetRecoveryEntry.create!(Code: i[1][0],name: i[1][1],Asset_type: i[1][2],Unit: i[1][3],Requisition_Amount: i[1][4],Amount_returned: i[1][5],Amount_Returnable: i[1][6],Asset_status: i[1][7],Requisition_Department: i[1][8], Requisition_Employeeld: i[1][9],Requisition_use: i[1][10] ,Asset_recovery_id:  @id);
       end
     else
       @id=params["id"]; 
       @asset_recovery= AssetRecovery.find_by(id: @id) 
       @asset_recovery.update(Documentnumber:params["Documentnumber"],Type_of_business: params["Type_of_business"],Requisition_Date: params["Requisition_Date"]);
       @Entry_by_Asset_recovery_id  = AssetRecoveryEntry.where( "Asset_recovery_id =  ?",  "#{params[:id]}")
       @Entry_by_Asset_recovery_id.each do  |id| 
           if  !params[:array_id].to_a.include?(id.id.to_s)
            assetRecoveryEntry_1 = AssetRecoveryEntry.find_by(id: id.id)
            assetRecoveryEntry_1.destroy
           end
       end 
       params[:datas].each do  |i|
         if  i[1][11].to_s == "0"
          puts "zzb"
          puts i[1][11]
          puts @id
          assetRecoveryEntry_3 = AssetRecoveryEntry.create!(Code: i[1][0],name: i[1][1],Asset_type: i[1][2],Unit: i[1][3],Requisition_Amount: i[1][4],Amount_returned: i[1][5],Amount_Returnable: i[1][6],Asset_status: i[1][7],Requisition_Department: i[1][8], Requisition_Employeeld: i[1][9],Requisition_use: i[1][10] ,Asset_recovery_id:  @id);
           
         else
          puts i[1][11];
          assetRecoveryEntry_2= AssetRecoveryEntry.find_by(id: i[1][11])
          assetRecoveryEntry_2.update(Code: i[1][0],name: i[1][1],Asset_type: i[1][2],Unit: i[1][3],Requisition_Amount: i[1][4],Amount_returned: i[1][5],Amount_Returnable: i[1][6],Asset_status: i[1][7],Requisition_Department: i[1][8], Requisition_Employeeld: i[1][9],Requisition_use: i[1][10] );
         end 
       end       
  end    
end
 


def destroy_multiple    

  params["AssetRecoveryid"].each do |i| 
    @Entry_by_Asset_recovery_id  = AssetRecoveryEntry.where( "Asset_recovery_id =  ?",  "#{i}")
    @Entry_by_Asset_recovery_id.each do |id|  
      assetRecoveryEntry_1 = AssetRecoveryEntry.find_by(id: id.id)
      assetRecoveryEntry_1.destroy
    end 
      AssetRecovery.destroy(i)  
end
  respond_to do |format|
    format.html { redirect_to asset_recoveries_url notice: '删除成功！.'  }
    format.json { head :no_content }
  end
end







  # GET /asset_recoveries
  # GET /asset_recoveries.json
  def index
    @asset_recoveries = AssetRecovery.all.page(params[:page]).per(10)
  end

  # GET /asset_recoveries/1
  # GET /asset_recoveries/1.json
  def show
  end

  # GET /asset_recoveries/new
  def new
    @asset_recovery = AssetRecovery.new
    @entry = AssetRecoveryEntry.new
  end

  # GET /asset_recoveries/1/edit
  def edit
    @assetRecoveryEntry  = AssetRecoveryEntry.where( "Asset_recovery_id =  ?",  "#{params[:id]}" )  
    
  end

  # POST /asset_recoveries
  # POST /asset_recoveries.json
  def create
    @asset_recovery = AssetRecovery.new(asset_recovery_params)

    respond_to do |format|
      if @asset_recovery.save
        format.html { redirect_to @asset_recovery, notice: 'Asset recovery was successfully created.' }
        format.json { render :show, status: :created, location: @asset_recovery }
      else
        format.html { render :new }
        format.json { render json: @asset_recovery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_recoveries/1
  # PATCH/PUT /asset_recoveries/1.json
  def update
    respond_to do |format|
      if @asset_recovery.update(asset_recovery_params)
        format.html { redirect_to @asset_recovery, notice: 'Asset recovery was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_recovery }
      else
        format.html { render :edit }
        format.json { render json: @asset_recovery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_recoveries/1
  # DELETE /asset_recoveries/1.json
  def destroy
    @asset_recovery.destroy
    respond_to do |format|
      format.html { redirect_to asset_recoveries_url, notice: 'Asset recovery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_recovery
      @asset_recovery = AssetRecovery.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_recovery_params
      params.require(:asset_recovery).permit(:Documentnumber, :Type_of_business, :Requisition_Date)
    end
end
