class AssetTurnoverDetailsController < ApplicationController
  before_action :set_asset_turnover_detail, only: [:show, :edit, :update, :destroy]
 

def destroy_multiple    

  params["asset_turnover_detailid"].each do |i| 
    puts i;
    @Entry_by_Asset_recovery_id  = AssetTurnoverDetailEntry.where( "AssetTurnoverDetail_id =  ?",  "#{i}")
    @Entry_by_Asset_recovery_id.each do |id|  
      assetTurnoverDetailEntry_1 = AssetTurnoverDetailEntry.find_by(id: id.id)
      assetTurnoverDetailEntry_1.destroy
    end 
    AssetTurnoverDetail.destroy(i)  
end
  respond_to do |format|
    format.html { redirect_to asset_turnover_details_url notice: '删除成功！.'  }
    format.json { head :no_content }
  end
end




  # GET /asset_turnover_details
  # GET /asset_turnover_details.json
  def index
    @asset_turnover_details = AssetTurnoverDetail.all.page(params[:page]).per(10)
  end

  # GET /asset_turnover_details/1
  # GET /asset_turnover_details/1.json
  def show
  end

  # GET /asset_turnover_details/new
  def new
    @asset_turnover_detail = AssetTurnoverDetail.new
    @entry = AssetTurnoverDetailEntry.new
    @assetcard  =  Assetcard.all
  end

  # GET /asset_turnover_details/1/edit
  def edit
    @assetTurnoverDetailEntry  = AssetTurnoverDetailEntry.where( "AssetTurnoverDetail_id =  ?",  "#{params[:id]}" )  
    @assetcard  =  Assetcard.all
    @index=0
  end


  # POST /asset_turnover_details
  # POST /asset_turnover_details.json
  def  save_all 
    @id=0;
   if params["id"]==""  
       @asset_turnover_detail = AssetTurnoverDetail.create!(Document_number:params["Document_number"],Borrowing_date: params["Borrowing_date"],Borrowing_Department: params["Borrowing_Department"],Borrowed_To_id:params["Borrowed_To_id"],Loaner:params["Loaner"]);
       @id=@asset_turnover_detail.id
       params["datas"].each do |i| 
         assetTurnoverDetailEntry = AssetTurnoverDetailEntry.create!(assetcards_Code: i[1][0],assetcards_name: i[1][1],Unit: i[1][2],Amount: i[1][3],Reasons_for_borrowing: i[1][4],givebackPlanDate: i[1][5],Has_Been_returned: i[1][6],givebackDate: i[1][7],Deptment: i[1][8], Employeeld: i[1][9],Asset_seat: i[1][10] ,Last_seat: i[1][11],AssetTurnoverDetail_id: @id);
       end
     else
       @id=params["id"]; 
       @asset_turnover_detail= AssetTurnoverDetail.find_by(id: @id) 
       @asset_turnover_detail.update(Document_number:params["Document_number"],Borrowing_date: params["Borrowing_date"],Borrowing_Department: params["Borrowing_Department"],Borrowed_To_id:params["Borrowed_To_id"],Loaner:params["Loaner"]);
       @Entry_by_AssetTurnoverDetail_id  = AssetTurnoverDetailEntry.where( "AssetTurnoverDetail_id =  ?",  "#{params[:id]}")
       @Entry_by_AssetTurnoverDetail_id.each do  |id| 
           if  !params[:array_id].to_a.include?(id.id.to_s)
             assetTurnoverDetailEntry_1 = AssetTurnoverDetailEntry.find_by(id: id.id)
             assetTurnoverDetailEntry_1.destroy
           end
       end 
       params[:datas].each do  |i|
         if  i[1][12].to_s == "0"
           assetTurnoverDetailEntry_3 = AssetTurnoverDetailEntry.create!(assetcards_Code: i[1][0],assetcards_name: i[1][1],Unit: i[1][2],Amount: i[1][3],Reasons_for_borrowing: i[1][4],givebackPlanDate: i[1][5],Has_Been_returned: i[1][6],givebackDate: i[1][7],Deptment: i[1][8], Employeeld: i[1][9],Asset_seat: i[1][10] ,Last_seat: i[1][11],AssetTurnoverDetail_id: @id);
           puts i[1][12];
         else
           assetTurnoverDetailEntry_2= AssetTurnoverDetailEntry.find_by(id: i[1][12])
           puts  i[1][12];
           assetTurnoverDetailEntry_2.update(assetcards_Code: i[1][0],assetcards_name: i[1][1],Unit: i[1][2],Amount: i[1][3],Reasons_for_borrowing: i[1][4],givebackPlanDate: i[1][5],Has_Been_returned: i[1][6],givebackDate: i[1][7],Deptment: i[1][8], Employeeld: i[1][9],Asset_seat: i[1][10] ,Last_seat: i[1][11]);
         end 
       end       
  end    
end
 


  # POST /asset_turnover_details
  # POST /asset_turnover_details.json
  def create
    @asset_turnover_detail = AssetTurnoverDetail.new(asset_turnover_detail_params)
    return;
    respond_to do |format|
      if @asset_turnover_detail.save
        puts @asset_turnover_detail.id
        format.html { redirect_to @asset_turnover_detail, notice: 'Asset turnover detail was successfully created.' }
        format.json { render :show, status: :created, location: @asset_turnover_detail }
      else
        format.html { render :new }
        format.json { render json: @asset_turnover_detail.errors, status: :unprocessable_entity }
      end
    end 
end

  # PATCH/PUT /asset_turnover_details/1
  # PATCH/PUT /asset_turnover_details/1.json
  def update
    respond_to do |format|
      if @asset_turnover_detail.update(asset_turnover_detail_params)
        format.html { redirect_to @asset_turnover_detail, notice: 'Asset turnover detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_turnover_detail }
      else
        format.html { render :edit }
        format.json { render json: @asset_turnover_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_turnover_details/1
  # DELETE /asset_turnover_details/1.json
  def destroy 
    @asset_turnover_detail.destroy
    respond_to do |format|
      format.html { redirect_to asset_turnover_details_url, notice: 'Asset turnover detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_turnover_detail
      @asset_turnover_detail = AssetTurnoverDetail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_turnover_detail_params
      params.require(:asset_turnover_detail).permit(:Document_number, :Borrowing_date, :Borrowing_Department, :Borrowed_To_id, :Loaner)
    end
end
