class AssetTurnoverDetailsController < ApplicationController
  before_action :set_asset_turnover_detail, only: [:show, :edit, :update, :destroy]
 


  def  Update_Fbillstatus 
    message=""
    ActiveRecord::Base.transaction do
    if params["Status"].lstrip.rstrip=="审核"
      @status="已审核" 
    else
      @status="未审核"
    end   
    @assetTurnoverDetail  = AssetTurnoverDetail.where( "id =  ? and fbillstatus= ?", params["id"],@status )  
    if    @assetTurnoverDetail.length==0 
      @assetTurnoverDetail = AssetTurnoverDetail.find(params["id"])
      @assetTurnoverDetail.update(Approver: session[:name],Approverdate:Time.now.strftime("%Y-%m-%d %H:%M:%S"),fbillstatus:  @status)

      if message.lstrip.rstrip!="" 
        render :json  => {code: 201,message: message}
        raise ActiveRecord::Rollback 
      else 
      message=  params["Status"]+"成功！" 
      render :json  => {code: 200,message: message}
      end
    else  
      message=   params[:Status].lstrip.rstrip+"失败！该单据已经是"+ @status+"状态，不允许"+ params[:Status]+"\r\n" 
      render :json  => {code: 201,message: message}
    end 
  end 
end



def destroy_multiple     
  ActiveRecord::Base.transaction do
    message="";
    params["asset_turnover_detailid"].each do |i|  
      @AssetTurnoverDetail = AssetTurnoverDetail.find(i);
      if @AssetTurnoverDetail.fbillstatus=="已审核"  #2021-1-15 阿斌修改，控制已审核不允许删除！
        message=message+"单据编号为：" +@AssetTurnoverDetail.Document_number+"已审核，不允许删除！\r\n";  #2021-1-15 阿斌修改，控制已审核不允许删除！
      else 
        @Entry_by_Asset_recovery_id  = AssetTurnoverDetailEntry.where( "AssetTurnoverDetail_id =  ?",  "#{i}")
        @Entry_by_Asset_recovery_id.each do |id|  
          assetTurnoverDetailEntry_1 = AssetTurnoverDetailEntry.find_by(id: id.id) 
          @assetcard=Assetcard.where("assetCode =  ?", assetTurnoverDetailEntry_1.assetcards_Code)#2021-1-15 阿斌修改，删除的过程中，修改状态
          @assetcard.update(Usestate_id: "可用")#2021-1-15 阿斌修改，删除的过程中，修改状态  
          assetTurnoverDetailEntry_1.destroy
          AssetTurnoverDetail.destroy(i)
          end
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
    @asset_turnover_detail.fbillstatus='未审核'
    @entry = AssetTurnoverDetailEntry.new
    @assetcard  =  Assetcard.where("Usestate_id='可用'");   
    @assetseate = Assetseate.all   
    @user = User.all   
    @department = Department.all   
  end

  # GET /asset_turnover_details/1/edit
  def edit
    IsRresh(); 
    @assetTurnoverDetailEntry  = AssetTurnoverDetailEntry.where( "AssetTurnoverDetail_id =  ?",  "#{params[:id]}" )  
    @assetcard  =  Assetcard.where("Usestate_id='可用'");   
    @index=0
    @user = User.all   
    @department = Department.all  
    @assetseate = Assetseate.all    
  end


  # POST /asset_turnover_details
  # POST /asset_turnover_details.json
  def  save_all  
    message=""  
    ActiveRecord::Base.transaction do
      @id=0;
    if params["id"]==""  
        message = message + Save_Check("资产借出/归还单",params ).to_s
        if message.lstrip.rstrip==""
           @asset_turnover_detail = AssetTurnoverDetail.create!(Document_number:params["Document_number"],Borrowing_date: params["Borrowing_date"],Borrowing_Department: params["Borrowing_Department"],Borrowed_To_id:params["Borrowed_To_id"],Loaner:params["Loaner"],Creator: session[:name],fbillstatus: '未审核', Createdate: Time.now.strftime("%Y-%m-%d %H:%M:%S"));
           @id=@asset_turnover_detail.id
           index =0;
           params["datas"].each do |i| 
             index+=1;
             message=message+Save_Check_Entry("资产借出/归还单",params,i,index) 
             assetTurnoverDetailEntry = AssetTurnoverDetailEntry.create!(assetcards_Code: i[1][0],assetcards_name: i[1][1],Unit: i[1][2],Amount: i[1][3],Reasons_for_borrowing: i[1][4],givebackPlanDate: i[1][5],Has_Been_returned: i[1][6],givebackDate: i[1][7],Deptment: i[1][8], Employeeld: i[1][9],Asset_seat: i[1][10] ,Last_seat: i[1][11],AssetTurnoverDetail_id: @id);
           end 
        end  
      else
        @id=params["id"]; 
        message = message + Save_Check("资产借出/归还单",params ).to_s 
        @asset_turnover_detail= AssetTurnoverDetail.find_by(id: @id) 
        if message.lstrip.rstrip=="" 
            @asset_turnover_detail.update(Document_number:params["Document_number"],Borrowing_date: params["Borrowing_date"],Borrowing_Department: params["Borrowing_Department"],Borrowed_To_id:params["Borrowed_To_id"],Loaner:params["Loaner"]);
            @Entry_by_AssetTurnoverDetail_id  = AssetTurnoverDetailEntry.where( "AssetTurnoverDetail_id =  ?",   @id)
            @Entry_by_AssetTurnoverDetail_id.each do  |id|  
                if  !params[:array_id].to_a.include?(id.id.to_s)
                  assetTurnoverDetailEntry_1 = AssetTurnoverDetailEntry.find_by(id: id.id) 
                  @assetcard=Assetcard.where("assetCode =  ?",  assetTurnoverDetailEntry_1. assetcards_Code)#2021-1-14 阿斌修改，删除的过程中，修改状态
                  @assetcard.update(Usestate_id: "可用")#2021-1-14 阿斌修改，删除的过程中，修改状态  
                  assetTurnoverDetailEntry_1.destroy
                end
            end 
            index =0;
            params[:datas].each do  |i|
              index+=1;
              message=message+ Save_Check_Entry("资产借出/归还单",params,i,index) 
              if(params[:type]=="归还") 
                message=message+ Update_Fbillstatus_Check_Entry("资产借出/归还单",params,i,index,params[:type]).to_s 
              end
              if  i[1][12].to_s == "0"
                assetTurnoverDetailEntry_3 = AssetTurnoverDetailEntry.create!(assetcards_Code: i[1][0],assetcards_name: i[1][1],Unit: i[1][2],Amount: i[1][3],Reasons_for_borrowing: i[1][4],givebackPlanDate: i[1][5],Has_Been_returned: i[1][6],givebackDate: i[1][7],Deptment: i[1][8], Employeeld: i[1][9],Asset_seat: i[1][10] ,Last_seat: i[1][11],AssetTurnoverDetail_id: @id);
              else
                assetTurnoverDetailEntry_2= AssetTurnoverDetailEntry.find_by(id: i[1][12])
                if   i[1][7].lstrip.rstrip!=""
                  i[1][6]='true';
              end
                assetTurnoverDetailEntry_2.update(assetcards_Code: i[1][0],assetcards_name: i[1][1],Unit: i[1][2],Amount: i[1][3],Reasons_for_borrowing: i[1][4],givebackPlanDate: i[1][5],Has_Been_returned: i[1][6],givebackDate: i[1][7],Deptment: i[1][8], Employeeld: i[1][9],Asset_seat: i[1][10] ,Last_seat: i[1][11]);
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
      params.require(:asset_turnover_detail).permit(:Document_number, :Borrowing_date, :Borrowing_Department, :Borrowed_To_id, :Loaner,:fbillstatus,:Creator,:Createdate,:Approver,:Approverdate)
    end
end
