class AssetTurnoverDetailsController < ApplicationController
  before_action :set_asset_turnover_detail, only: [:show, :edit, :update, :destroy]
 

#返回Json数据
  def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
    render json:{code: code, msg: message, count: count,data: data};
  end

#获取接口数据
  def Get_DataApi
    #获取单据数据
    assetTurnoverDetail=AssetTurnoverDetail.order(:id);
    #获取单据总数
    total_count=assetTurnoverDetail.count
    #分页
    assetTurnoverDetail=assetTurnoverDetail.page(params[:page]).per(params[:limit])
    #数据转换成Json格式
    data=assetTurnoverDetail.as_json;
    #返回Json数据
    api_success(count: total_count,data: data)
  end



#判断是否允许下推
  def Check_IsPush
    #查找是否存在允许下推的数据行
    sql="select a.* from asset_turnover_detail_entries a  inner join asset_turnover_details   b  on  b.id=a.AssetTurnoverDetail_id left  join asset_turnover_detail_entries c on c.FSrcFbillno=b.Document_number and c.FSrcFseq  = a.fseq  where  c.id  is   null and   b.id=" + params[:id]
    @assetPickingEntry =AssetPickingEntry.find_by_sql (sql) 
    if @assetPickingEntry.length==0
      #没有存在允许下推的数据行
      render :json  => {code: 201,message: "不允许下推条件，请检查单据体是否已经下推！"}
    else
      #存在允许下推的数据行
      render :json  => {code: 200,message: ""}
    end
  end
  



#更新单据状态
  def Update_Fbillstatus  
    #返回信息
    message=""
    #事务
    ActiveRecord::Base.transaction do 
      @assetTurnoverDetail=AssetTurnoverDetail.find(params[:id]) 
      if params[:fbillstatus]=="审核"
        @Fbillstatus="已审核"
      else
        @Fbillstatus="未审核"
      end 
      #更新状态检验
      message=message+ Update_Fbillstatus_Check("资产借出/归还单",params[:id],params[:fbillstatus]).to_s   
      if  message.lstrip.rstrip==""
        #检验通过，更新状态
        @assetTurnoverDetail.update(fbillstatus:@Fbillstatus)
        if(params[:fbillstatus]=="审核")
          #审核操作则更新审核人、审核日期
          @assetTurnoverDetail.update(Approver: session[:name],Approverdate: Time.now.strftime("%Y-%m-%d %H:%M:%S")) 
        end
        #更新资产卡片数据
        Update_datas("资产借出/归还单",params,"");  
        message=params[:fbillstatus].to_s + "成功！"
      end 
    end 
      render :json  => {code: 200,message: message,id: @id}
  end

 


#删除
def destroy_multiple     
  #事务
  ActiveRecord::Base.transaction do
    #返回信息
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
          end  
          AssetTurnoverDetail.destroy(i)
        end
      end
      if message.lstrip.rstrip!=""
        #不允许删除
        render :json  => {code: 201,message: message }
        raise ActiveRecord::Rollback 
      else
        #允许删除
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
      #没有参数，业务类型为借出
      @asset_turnover_detail.Type_of_business="借出" 
    else
      #有参数，业务类型为归还、借用部门、借用人为上游单据的借用部门、借用人
      @assetTurnoverDetail_old=AssetTurnoverDetail.find(params[:id]) 
      @asset_turnover_detail.Type_of_business="归还" 
      @asset_turnover_detail.Borrowing_Department=@assetTurnoverDetail_old.Borrowing_Department
      @asset_turnover_detail.Loaner=@assetTurnoverDetail_old.Loaner 
      sql="select a.* from asset_turnover_detail_entries a  inner join asset_turnover_details   b  on  b.id=a.AssetTurnoverDetail_id left  join asset_turnover_detail_entries c on c.FSrcFbillno=b.Document_number and c.FSrcFseq  = a.fseq  where  c.id  is   null and   b.id=" + params[:id]
      @assetTurnoverDetailEntry =AssetTurnoverDetailEntry.find_by_sql (sql) 
      @seq=0
      @assetTurnoverDetailEntry.each do |i|    
        @seq+=1;
        #源单编号为上游单据的单据编号
        i.FSrcFbillno=@assetTurnoverDetail_old.Document_number
        @assetTurnoverDetailEntry_old=AssetTurnoverDetailEntry.find(i.id)   
        #源单行号为上游单据行的行号
        i.FSrcFseq=@assetTurnoverDetailEntry_old.fseq 
        i.fseq=@seq
      end
    end
 #单据状态默认为未审核
    @asset_turnover_detail.fbillstatus='未审核'
    #单据日期为当前日期
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
 



#保存
  def  save_all
    #返回信息
    message=""   
    #事务
    ActiveRecord::Base.transaction do
      @id=0;
      if params["id"]==""  
        #保存检验
        message = message + Save_Check("资产借出/归还单",params).to_s
        if message.lstrip.rstrip==""
          #检验通过
          #保存单据头
          @AssetTurnoverDetail = AssetTurnoverDetail.create!(Document_number:params["Document_number"],Type_of_business: params["Type_of_business"],Borrowing_date: params["Borrowing_date"],Borrowing_Department: params["Borrowing_Department"],Borrowed_To_id:params["Borrowed_To_id"],Loaner:params["Loaner"],Creator: session[:name],fbillstatus: '未审核', Createdate: Time.now.strftime("%Y-%m-%d %H:%M:%S"));
          @id=@AssetTurnoverDetail.id
          index =0; 
          params["datas"].each do |i| 
            index+=1;
            #单据头检验
            message=message+Save_Check_Entry("资产借出/归还单",params,i,index) 
            #资产位置如是双击选择资产位置则置空
            if i[1][12].lstrip.rstrip =="双击选择资产位置"
              i[1][12]="";
            end
            #保存单据体
            @AssetTurnoverDetailEntry = AssetTurnoverDetailEntry.create!(assetcards_Code: i[1][0],assetcards_name: i[1][1],Unit: i[1][2],Amount: i[1][3],Reasons_for_borrowing: i[1][4],  Deptment: i[1][5], Employeeld: i[1][6],Asset_seat: i[1][7] ,Last_seat: i[1][8],FSrcFbillno:i[1][9],FSrcFseq: i[1][10],fseq:i[1][12],AssetTurnoverDetail_id:@id);
     
          end
        end
      else
        #单据修改保存
        @id=params["id"];  
        #单据头保存检验
        message = message + Save_Check("资产借出/归还单",params ).to_s 
        @AssetTurnoverDetail= AssetTurnoverDetail.find_by(id: @id) 
        if message.lstrip.rstrip=="" 
          #检验通过，修改单据头信息
          @AssetTurnoverDetail.update(Document_number:params["Document_number"],Borrowing_date: params["Borrowing_date"],Type_of_business: params["Type_of_business"],Borrowing_Department: params["Borrowing_Department"],Borrowed_To_id:params["Borrowed_To_id"],Loaner:params["Loaner"]);
          @AssetTurnoverDetailEntry1  = AssetTurnoverDetailEntry.where( "AssetTurnoverDetail_id =  ?",   @id)
          @AssetTurnoverDetailEntry1.each do  |id| 
            if  !params[:array_id].to_a.include?(id.id.to_s)
              #相对比修改上一次的单据体记录，不存在则删除
              @AssetTurnoverDetailEntry_1 = AssetTurnoverDetailEntry.find(id.id)  
              @AssetTurnoverDetailEntry_1.destroy
            end
          end
          index =0;
          params[:datas].each do  |i|
            index+=1;
            #单据体保存检验
            message=message+ Save_Check_Entry("资产借出/归还单",params,i,index) 
            if  i[1][11].to_s == "0" 
              #相对比修改时上一次的单据体记录，新增的单据体
              #资产位置如是双击选择资产位置则置空
              if i[1][8].lstrip.rstrip =="双击选择资产位置"
                i[1][8]="";
              end
              @AssetTurnoverDetailEntry_3 = AssetTurnoverDetailEntry.create!(assetcards_Code: i[1][0],assetcards_name: i[1][1],Unit: i[1][2],Amount: i[1][3],Reasons_for_borrowing: i[1][4],  Deptment: i[1][5], Employeeld: i[1][6],Asset_seat: i[1][7] ,Last_seat: i[1][8],FSrcFbillno:i[1][9],FSrcFseq: i[1][10],fseq:i[1][12],AssetTurnoverDetail_id:@id);
            else
                        #相对比修改时上一次的单据体记录，修改的单据体
              @AssetTurnoverDetailEntry_2= AssetTurnoverDetailEntry.find(i[1][11]) 
              if i[1][8].lstrip.rstrip =="双击选择资产位置"
                            #资产位置如是双击选择资产位置则置空
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
