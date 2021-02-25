class AssetTurnoverDetailsController < ApplicationController
  before_action :set_asset_turnover_detail, only: [:show, :edit, :update, :destroy]
 


  def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
    render json:{code: code, msg: message, count: count,data: data};
  end


  def Get_DataApi
    assetTurnoverDetail=AssetTurnoverDetail.order(:id);
    total_count=assetTurnoverDetail.count
    assetTurnoverDetail=assetTurnoverDetail.page(params[:page]).per(params[:limit])
    data=assetTurnoverDetail.as_json;
    api_success(count: total_count,data: data)
  end




  def Check_IsPush
    sql="select a.* from asset_turnover_detail_entries a  inner join asset_turnover_details   b  on  b.id=a.AssetTurnoverDetail_id left  join asset_turnover_detail_entries c on c.FSrcFbillno=b.Document_number and c.FSrcFseq  = a.fseq  where  c.id  is   null and   b.id=" + params[:id]
    @assetPickingEntry =AssetPickingEntry.find_by_sql (sql) 
    if @assetPickingEntry.length==0
      render :json  => {code: 201,message: "不允许下推条件，请检查单据体是否已经下推！"}
    else
      render :json  => {code: 200,message: ""}
    end
  end
  




  def Update_Fbillstatus  
    message=""
    ActiveRecord::Base.transaction do

      @assetTurnoverDetail=AssetTurnoverDetail.find(params[:id]) 
      if params[:fbillstatus]=="审核"
        @Fbillstatus="已审核"
      else
        @Fbillstatus="未审核"
      end 
      message=message+ Update_Fbillstatus_Check("资产借出/归还单",params[:id],params[:fbillstatus]).to_s   
      if  message.lstrip.rstrip==""
        @assetTurnoverDetail.update(fbillstatus:@Fbillstatus)
        if(params[:fbillstatus]=="审核")
          @assetTurnoverDetail.update(Approver: session[:name],Approverdate: Time.now.strftime("%Y-%m-%d %H:%M:%S")) 
        end
        Update_datas("资产借出/归还单",params,"");  
        message=params[:fbillstatus].to_s + "成功！"
      end 
    end 
      render :json  => {code: 200,message: message,id: @id}
  end

 



def destroy_multiple     
  ActiveRecord::Base.transaction do
    message="";
    params["asset_turnover_detailsid"].each do |i|  
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
          puts "开始"
          end  
          AssetTurnoverDetail.destroy(i)
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
    if (!params.include? 'id')
      @asset_turnover_detail.Type_of_business="借出"
      
    else
      @assetTurnoverDetail_old=AssetTurnoverDetail.find(params[:id]) 
      @asset_turnover_detail.Type_of_business="归还" 
      @asset_turnover_detail.Borrowing_Department=@assetTurnoverDetail_old.Borrowing_Department
      @asset_turnover_detail.Loaner=@assetTurnoverDetail_old.Loaner
 
      sql="select a.* from asset_turnover_detail_entries a  inner join asset_turnover_details   b  on  b.id=a.AssetTurnoverDetail_id left  join asset_turnover_detail_entries c on c.FSrcFbillno=b.Document_number and c.FSrcFseq  = a.fseq  where  c.id  is   null and   b.id=" + params[:id]
      @assetTurnoverDetailEntry =AssetTurnoverDetailEntry.find_by_sql (sql) 
      @seq=0
      @assetTurnoverDetailEntry.each do |i|    
        @seq+=1;
        i.FSrcFbillno=@assetTurnoverDetail_old.Document_number
        @assetTurnoverDetailEntry_old=AssetTurnoverDetailEntry.find(i.id)   
        i.FSrcFseq=@assetTurnoverDetailEntry_old.fseq 
        i.fseq=@seq
      end
    end






    @asset_turnover_detail.fbillstatus='未审核'
    @asset_turnover_detail.Borrowing_date= Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @entry = AssetTurnoverDetailEntry.new
    @assetcard  =  Assetcard.where("Usestate_id='可用'  and fbillstatus ='已审核' ");  
    @assetseate = Assetseate.all   
    @user = User.all   
    @department = Department.all   
  end

  # GET /asset_turnover_details/1/edit
  def edit
    IsRresh(); 
    @assetTurnoverDetailEntry  = AssetTurnoverDetailEntry.where( "AssetTurnoverDetail_id =  ?",  "#{params[:id]}" )  
    @assetcard  =  Assetcard.where("Usestate_id='可用'  and fbillstatus ='已审核' ");  
    @index=0
    @user = User.all   
    @department = Department.all  
    @assetseate = Assetseate.all    
  end
 




  def  save_all
    message=""   
    ActiveRecord::Base.transaction do
      @id=0;
      if params["id"]==""  
        message = message + Save_Check("资产借出/归还单",params).to_s
        if message.lstrip.rstrip==""
          @AssetTurnoverDetail = AssetTurnoverDetail.create!(Document_number:params["Document_number"],Type_of_business: params["Type_of_business"],Borrowing_date: params["Borrowing_date"],Borrowing_Department: params["Borrowing_Department"],Borrowed_To_id:params["Borrowed_To_id"],Loaner:params["Loaner"],Creator: session[:name],fbillstatus: '未审核', Createdate: Time.now.strftime("%Y-%m-%d %H:%M:%S"));
          @id=@AssetTurnoverDetail.id
          index =0; 
          params["datas"].each do |i| 
            index+=1;
            message=message+Save_Check_Entry("资产借出/归还单",params,i,index) 
            if i[1][12].lstrip.rstrip =="双击选择资产位置"
              i[1][12]="";
            end
            @AssetTurnoverDetailEntry = AssetTurnoverDetailEntry.create!(assetcards_Code: i[1][0],assetcards_name: i[1][1],Unit: i[1][2],Amount: i[1][3],Reasons_for_borrowing: i[1][4],  Deptment: i[1][5], Employeeld: i[1][6],Asset_seat: i[1][7] ,Last_seat: i[1][8],FSrcFbillno:i[1][9],FSrcFseq: i[1][10],fseq:i[1][12],AssetTurnoverDetail_id:@id);
     
          end
        end
      else
        @id=params["id"];  
        message = message + Save_Check("资产借出/归还单",params ).to_s 
        @AssetTurnoverDetail= AssetTurnoverDetail.find_by(id: @id) 
        if message.lstrip.rstrip=="" 
          @AssetTurnoverDetail.update(Document_number:params["Document_number"],Borrowing_date: params["Borrowing_date"],Type_of_business: params["Type_of_business"],Borrowing_Department: params["Borrowing_Department"],Borrowed_To_id:params["Borrowed_To_id"],Loaner:params["Loaner"]);
           
          @AssetTurnoverDetailEntry1  = AssetTurnoverDetailEntry.where( "AssetTurnoverDetail_id =  ?",   @id)
          @AssetTurnoverDetailEntry1.each do  |id| 
            if  !params[:array_id].to_a.include?(id.id.to_s)
              @AssetTurnoverDetailEntry_1 = AssetTurnoverDetailEntry.find(id.id)  
              @AssetTurnoverDetailEntry_1.destroy
            end
          end
          index =0;
          params[:datas].each do  |i|
            index+=1;
            message=message+ Save_Check_Entry("资产借出/归还单",params,i,index) 
            if  i[1][11].to_s == "0"
              if i[1][8].lstrip.rstrip =="双击选择资产位置"
                i[1][8]="";
              end
              @AssetTurnoverDetailEntry_3 = AssetTurnoverDetailEntry.create!(assetcards_Code: i[1][0],assetcards_name: i[1][1],Unit: i[1][2],Amount: i[1][3],Reasons_for_borrowing: i[1][4],  Deptment: i[1][5], Employeeld: i[1][6],Asset_seat: i[1][7] ,Last_seat: i[1][8],FSrcFbillno:i[1][9],FSrcFseq: i[1][10],fseq:i[1][12],AssetTurnoverDetail_id:@id);
            else 
              @AssetTurnoverDetailEntry_2= AssetTurnoverDetailEntry.find(i[1][11]) 
              if i[1][8].lstrip.rstrip =="双击选择资产位置"
                i[1][8]="";
              end
              @AssetTurnoverDetailEntry_2.update(assetcards_Code: i[1][0],assetcards_name: i[1][1],Unit: i[1][2],Amount: i[1][3],Reasons_for_borrowing: i[1][4],  Deptment: i[1][5], Employeeld: i[1][6],Asset_seat: i[1][7] ,Last_seat: i[1][8],FSrcFbillno:i[1][9],FSrcFseq: i[1][10],fseq:i[1][12]);
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
      params.require(:asset_turnover_detail).permit(:Document_number, :Borrowing_date, :Borrowing_Department, :Borrowed_To_id, :Loaner,:fbillstatus,:Creator,:Createdate,:Approver,:Approverdate,:Type_of_business)
    end
end
