class AssetScrappingsController < ApplicationController
  before_action :set_asset_scrapping, only: [:show, :edit, :update, :destroy]

#删除
  def destroy_multiple     
    params["asset_scrappingid"].each do |i|  
      @Entry_by_Asset_Scrapping_id  = AssetScrappingEntry.where( "Asset_Scrapping_id =  ?",  "#{i}")
      @Entry_by_Asset_Scrapping_id.each do |id|  
        #删除单据体
        assetScrappingEntry_1 = AssetScrappingEntry.find_by(id: id.id)
        assetScrappingEntry_1.destroy
      end 
      #删除单据头
      AssetScrapping.destroy(i)  
  end
    respond_to do |format|
      format.html { redirect_to asset_scrappings_url notice: '删除成功！.'  }
      format.json { head :no_content }
    end
  end
  


#保存
  def  save_all 
    @id=0;
   if params["id"]==""    
    #单据新增保存 
    #创建单据头
       @assetScrapping = AssetScrapping.create!(Document_number:params["Document_number"],Date: params["Date"],Addtype: params["Addtype"],Addtype_Reason:params["Addtype_Reason"]);
       @id=@assetScrapping.id
       params["datas"].each do |i|    
        #创建单据体
       assetScrappingEntry = AssetScrappingEntry.create!(Code: i[1][0],Name: i[1][1],Unit: i[1][2],Amount: i[1][3],Scrapping_Amount: i[1][4],Asset_seat: i[1][5],Asset_Scrapping_id: @id);
       end
     else
      #单据修改保存
       @id=params["id"]; 
       @assetScrapping= AssetScrapping.find_by(id: @id) 
       #修改单据头
       @assetScrapping.update(Document_number:params["Document_number"],Date: params["Date"],Addtype: params["Addtype"],Addtype_Reason:params["Addtype_Reason"]);
       @Entry_by_Asset_Asset_Scrapping_id  = AssetScrappingEntry.where( "Asset_Scrapping_id =  ?",  "#{params[:id]}")
       @Entry_by_Asset_Asset_Scrapping_id.each do  |id| 
           if  !params[:array_id].to_a.include?(id.id.to_s)
            #相对比修改上一次的单据体记录，不存在则删除
            assetScrappingEntry_1 = AssetScrappingEntry.find_by(id: id.id)
            assetScrappingEntry_1.destroy
           end
       end 
       params[:datas].each do  |i|
         if  i[1][6].to_s == "0"
          #相对比修改时上一次的单据体记录，新增的单据体
          #创建单据体
          assetScrappingEntry_3 = AssetScrappingEntry.create!(Code: i[1][0],Name: i[1][1],Unit: i[1][2],Amount: i[1][3],Scrapping_Amount: i[1][4],Asset_seat: i[1][5],Asset_Scrapping_id: @id);
         else
          #相对比修改时上一次的单据体记录，修改的单据体
          assetScrappingEntry_2= AssetScrappingEntry.find_by(id: i[1][6])
          #更新单据体
          assetScrappingEntry_2.update(Code: i[1][0],Name: i[1][1],Unit: i[1][2],Amount: i[1][3],Scrapping_Amount: i[1][4],Asset_seat: i[1][5]);
         end 
       end       
  end    
end




  # GET /asset_scrappings
  # GET /asset_scrappings.json
  def index
    @asset_scrappings = AssetScrapping.all.page(params[:page]).per(10)
  end

  # GET /asset_scrappings/1
  # GET /asset_scrappings/1.json
  def show
  end

  # GET /asset_scrappings/new
  def new
    @asset_scrapping = AssetScrapping.new
    @entry = AssetScrappingEntry.new 
  end

  # GET /asset_scrappings/1/edit
  def edit 
    @asset_scrapping_entry  = AssetScrappingEntry.where( "Asset_Scrapping_id =  ?",  "#{params[:id]}")
  end

  # POST /asset_scrappings
  # POST /asset_scrappings.json
  def create
    @asset_scrapping = AssetScrapping.new(asset_scrapping_params) 
    respond_to do |format|
      if @asset_scrapping.save
        format.html { redirect_to @asset_scrapping, notice: 'Asset scrapping was successfully created.' }
        format.json { render :show, status: :created, location: @asset_scrapping }
      else
        format.html { render :new }
        format.json { render json: @asset_scrapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_scrappings/1
  # PATCH/PUT /asset_scrappings/1.json
  def update
    respond_to do |format|
      if @asset_scrapping.update(asset_scrapping_params)
        format.html { redirect_to @asset_scrapping, notice: 'Asset scrapping was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_scrapping }
      else
        format.html { render :edit }
        format.json { render json: @asset_scrapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_scrappings/1
  # DELETE /asset_scrappings/1.json
  def destroy
    @asset_scrapping.destroy
    respond_to do |format|
      format.html { redirect_to asset_scrappings_url, notice: 'Asset scrapping was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_scrapping
      @asset_scrapping = AssetScrapping.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_scrapping_params
      params.require(:asset_scrapping).permit(:Document_number, :Date, :Addtype, :Addtype_Reason)
    end
end
