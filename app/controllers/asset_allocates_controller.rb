class AssetAllocatesController < ApplicationController
  before_action :set_asset_allocate, only: [:show, :edit, :update, :destroy]


  def destroy_multiple    

    params["asset_allocateid"].each do |i| 
      puts i;
      @Entry_by_Asset_allocate_id  = AssetAllocateEntry.where( "Asset_allocate_id =  ?",  "#{i}")
      @Entry_by_Asset_allocate_id.each do |id|  
        assetAllocateEntry_1 = AssetAllocateEntry.find_by(id: id.id)
        assetAllocateEntry_1.destroy
      end 
      AssetAllocate.destroy(i)  
  end
    respond_to do |format|
      format.html { redirect_to asset_allocates_url notice: '删除成功！.'  }
      format.json { head :no_content }
    end
  end
  


  def  save_all 
    @id=0;
   if params["id"]==""    
       @asset_allocates = AssetAllocate.create!(Document_number:params["Document_number"],Pull_up_to_id: params["Pull_up_to_id"],Bring_in_to_id: params["Bring_in_to_id"],Pull_up_date:params["Pull_up_date"],Allocate_reason:params["Allocate_reason"],Bring_in_Number:params["Bring_in_Number"],Bring_in_Confirm:params["Bring_in_Confirm"]);
       @id=@asset_allocates.id
       params["datas"].each do |i|  
       assetAllocateEntry = AssetAllocateEntry.create!(Code: i[1][0],name: i[1][1],Unit: i[1][2],Amount: i[1][3],Transfer_out_quantity: i[1][4],Asset_seat: i[1][5],Asset_allocate_id: @id);
       end
     else
       @id=params["id"]; 
       @asset_allocates= AssetAllocate.find_by(id: @id) 
       @asset_allocates.update(Document_number:params["Document_number"],Pull_up_to_id: params["Pull_up_to_id"],Bring_in_to_id: params["Bring_in_to_id"],Pull_up_date:params["Pull_up_date"],Allocate_reason:params["Allocate_reason"],Bring_in_Number:params["Bring_in_Number"],Bring_in_Confirm:params["Bring_in_Confirm"]);
       @Entry_by_Asset_allocate_id  = AssetAllocateEntry.where( "Asset_allocate_id =  ?",  "#{params[:id]}")
       @Entry_by_Asset_allocate_id.each do  |id| 
           if  !params[:array_id].to_a.include?(id.id.to_s)
            assetAllocateEntry_1 = AssetAllocateEntry.find_by(id: id.id)
            assetAllocateEntry_1.destroy
           end
       end 
       params[:datas].each do  |i|
         if  i[1][6].to_s == "0"
          assetAllocateEntry_3 = AssetAllocateEntry.create!(Code: i[1][0],name: i[1][1],Unit: i[1][2],Amount: i[1][3],Transfer_out_quantity: i[1][4],Asset_seat: i[1][5],Asset_allocate_id: @id);
           puts i[1][6];
         else
          assetAllocateEntry_2= AssetAllocateEntry.find_by(id: i[1][6])
          assetAllocateEntry_2.update(Code: i[1][0],name: i[1][1],Unit: i[1][2],Amount: i[1][3],Transfer_out_quantity: i[1][4],Asset_seat: i[1][5]);
         end 
       end       
  end    
end



  # GET /asset_allocates
  # GET /asset_allocates.json
  def index
    @asset_allocates = AssetAllocate.all.page(params[:page]).per(10)
  end

  # GET /asset_allocates/1
  # GET /asset_allocates/1.json
  def show
  end

  # GET /asset_allocates/new
  def new
    @asset_allocate = AssetAllocate.new
    @entry = AssetAllocateEntry.new
  end

  # GET /asset_allocates/1/edit
  def edit 
     @assetAllocateEntry  = AssetAllocateEntry.where( "Asset_allocate_id =  ?",  "#{params[:id]}" )  
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
      params.require(:asset_allocate).permit(:Document_number, :Pull_up_to_id, :Bring_in_to_id, :Pull_up_date, :Allocate_reason, :Bring_in_Number, :Bring_in_Confirm)
    end
end
