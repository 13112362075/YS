class AssetCountingreportsController < ApplicationController
  before_action :set_asset_countingreport, only: [:show, :edit, :update, :destroy]


#批量删除
  def destroy_multiple     
        #事务
    ActiveRecord::Base.transaction do
      #返回信息
      message="";
      #根据单据id循环
      params["asset_countingreportsid"].each do |i|  
        #删除检验
        message =message +  Delete_Check("资产作业单",i ).to_s
        if message.lstrip.rstrip =="" 
          #删除检验通过
          @Entry_by_Asset_recovery_id  = AssetCountingreportEntry.where( "Asset_Countingreport_id =  ?",  "#{i}")
          #删除所对应的单据体
          @Entry_by_Asset_recovery_id.each do |id|
            @AssetCountingreportEntry_1 = AssetCountingreportEntry.find(id.id)  
            @AssetCountingreportEntry_1.destroy
          end 
          #删除单据头
          AssetCountingreport.destroy(i) 
        end
      end 
      if message.lstrip.rstrip!=""
        #删除检验不通过，事务回滚
        render :json  => {code: 201,message: message }
        raise ActiveRecord::Rollback 
      else
        #删除成功！
        render :json  => {code: 200,message: "删除成功！" }
      end
    end
  end




#返回Json数据
  def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
    render json:{code: code, msg: message, count: count,data: data};
  end
 

#构建Api接口
  def Get_DataApi
        #返回所有单据信息
    assetCountingreport=AssetCountingreport.order(:id);
        #返回单据总数量
    total_count=assetCountingreport.count
        #分页
    assetCountingreport=assetCountingreport.page(params[:page]).per(params[:limit])
        #转换Json数据
    data=assetCountingreport.as_json;
    #返回Json数据
    api_success(count: total_count,data: data)
  end


#根据数据状态
  def Update_fbillstatus  
        #返回信息
    message=""
    #事务
    ActiveRecord::Base.transaction do 

      @assetCountingreport=AssetCountingreport.find(params[:id]) 
      if params[:fbillstatus]=="审核"
        @Fbillstatus="已审核"
      else
        @Fbillstatus="未审核"
      end 
      #修改状态检验
      message=message+ Update_Fbillstatus_Check("资产作业单",params[:id],params[:fbillstatus]).to_s  
      if  message.lstrip.rstrip==""
        #检验通过，更新单据状态
        @assetCountingreport.update(fbillstatus:@Fbillstatus)
        if(params[:fbillstatus]=="审核")
          #审核操作，则更新审核人和审核日期
          @assetCountingreport.update(Approver: session[:name],APPROVEDATE: Time.now.strftime("%Y-%m-%d %H:%M:%S")) 
          #自动生成盘盈盘亏单 
          @Entry_by_Asset_recovery_id  = AssetCountingreportEntry.where( "Asset_Countingreport_id =  ?",  "#{params[:id]}")
          #获取盘盈记录
          @Entry_by_gain  = AssetCountingreportEntry.where( "Asset_Countingreport_id =  ? and Variance>0",  "#{params[:id]}")
          #获取盘亏记录
          @Entry_by_loss  = AssetCountingreportEntry.where( "Asset_Countingreport_id =  ?  and  Variance<0",  "#{params[:id]}")
          if(@Entry_by_gain.length>0)
            #如果有盘盈，则自动生成盘盈单
            @AssetGain = AssetGain.create!(BillNo:@assetCountingreport.BillNo.to_s+"_Gain",description: "",fdate: @assetCountingreport.fdate,fbillstatus:"未审核",Creator:session[:name],CREATEDATE:Time.now.strftime("%Y-%m-%d %H:%M:%S")); 
          end
          if(@Entry_by_loss.length>0) 
            #如果有盘亏，则自动生成盘亏单
            @AssetLoss=AssetLoss.create(BillNo:@assetCountingreport.BillNo.to_s+"_Loss",description: "",fdate: @assetCountingreport.fdate,fbillstatus:"未审核",Creator:session[:name],CREATEDATE:Time.now.strftime("%Y-%m-%d %H:%M:%S")); 
          end
          @countgain=0;
          @countloss=0;
          @Entry_by_Asset_recovery_id.each do |id| 
            #循环单据体
            @assetCountingreportEntry = AssetCountingreportEntry.find(id.id)    
            @assetCountingreportEntry.update(CountDate: @assetCountingreport.fdate)
            if(@assetCountingreportEntry.Variance>0) 
              @countgain=@countgain+1 
              #创建盘盈单单据体
              @AssetGainEntry= AssetGainEntry.create!(Code:@assetCountingreportEntry.Code,name: @assetCountingreportEntry.name,Asset_type: @assetCountingreportEntry.Asset_type,
                Unit: @assetCountingreportEntry.Unit,BookQty:@assetCountingreportEntry.BookQty,CountQty: @assetCountingreportEntry.CountQty,GainQty: @assetCountingreportEntry.Variance.abs(),
                Book_seat:@assetCountingreportEntry.Book_seat,Book_dept:@assetCountingreportEntry.Book_dept,Book_User: @assetCountingreportEntry.Book_User,Actual_seat:@assetCountingreportEntry.Invent_seat,Actual_dept:@assetCountingreportEntry.Invent_dept,Actual_User:@assetCountingreportEntry.InventUser,fseq:@countgain,Asset_Gain_id: @AssetGain.id,FSrcFbillno:@assetCountingreport.BillNo,FSrcFseq:@assetCountingreportEntry.fseq); 
            elsif(@assetCountingreportEntry.Variance<0)
              @countloss=@countloss+1 
              #创建盘亏单单据体
              @AssetGainEntry= AssetLossEntry.create!(Code:@assetCountingreportEntry.Code,name: @assetCountingreportEntry.name,Asset_type: @assetCountingreportEntry.Asset_type,
                Unit: @assetCountingreportEntry.Unit,BookQty:@assetCountingreportEntry.BookQty,CountQty: @assetCountingreportEntry.CountQty,LossQty: @assetCountingreportEntry.Variance.abs(),
                Book_seat:@assetCountingreportEntry.Book_seat,Book_dept:@assetCountingreportEntry.Book_dept,Book_User: @assetCountingreportEntry.Book_User,Actual_seat:@assetCountingreportEntry.Invent_seat,Actual_dept:@assetCountingreportEntry.Invent_dept,Actual_User:@assetCountingreportEntry.InventUser,fseq:@countloss,Asset_Loss_id: @AssetLoss.id,FSrcFbillno:@assetCountingreport.BillNo,FSrcFseq:@assetCountingreportEntry.fseq); 
            end
          end  
        end
        message=params[:fbillstatus].to_s + "成功！"
      end 
    end 
      render :json  => {code: 200,message: message,id: @id}
  end


#保存
  def save_all
    #返回信息
    message=""   
    #事务
    ActiveRecord::Base.transaction do
      @id=0;
      if params["id"]==""  
        #单据新建
        #单据头保存检验
        message = message + Save_Check("资产盘点单",params).to_s
        if message.lstrip.rstrip==""   
          #单据头检验通过，创建单据头
          @AssetCountingreport = AssetCountingreport.create!(BillNo:params["FBillno"],description: params["description"],fdate: params["fdate"],Creator: session[:name],fbillstatus: '未审核', CREATEDATE: Time.now.strftime("%Y-%m-%d %H:%M:%S"));
          @id=@AssetCountingreport.id
          index =0; 
          params["datas"].each do |i| 
            index+=1;
            #单据体保存检验
            message=message+Save_Check_Entry("资产盘点单",params,i,index)   
            #创建单据体 
            @AssetCountingreportEntry = AssetCountingreportEntry.create!(Code: i[1][0],name: i[1][1],Asset_type: i[1][2],Unit: i[1][3],Model: i[1][4],Asset_status: i[1][5],BookQty: i[1][6] ,
              CountQty: i[1][7],Variance: i[1][8],Book_seat: i[1][9],Book_dept:i[1][10],Book_User:i[1][11],Invent_seat:i[1][12],Invent_dept:i[1][13],InventUser:i[1][14],CountDate:i[1][15],
              Headnote:i[1][16],fseq:i[1][18],Asset_Countingreport_id:@id);
          end
        end
      else
        #单据修改保存
        @id=params["id"];  
        #单据头保存检验
        message = message + Save_Check("资产盘点单",params ).to_s 
        @AssetCountingreport= AssetCountingreport.find_by(id: @id) 
        if message.lstrip.rstrip=="" 
          #检验通过
          @AssetCountingreport.update(BillNo:params["FBillno"],description: params["description"],fdate: params["fdate"]);
          @AssetCountingreportEntry1  = AssetCountingreportEntry.where( "Asset_Countingreport_id =  ?",   @id)
          @AssetCountingreportEntry1.each do  |id| 
            if  !params[:array_id].to_a.include?(id.id.to_s)
              #相对应比上次的单据体记录，不存在则删除
              @AssetCountingreportEntry_1 = AssetCountingreportEntry.find(id.id) 
              @assetcard=Assetcard.where("Code =  ?",  @AssetCountingreportEntry_1. Code)#2021-1-14 阿斌修改，删除的过程中，修改状态
              #@assetcard.update(Usestate_id: "可用")#2021-1-14 阿斌修改，删除的过程中，修改状态  
              @AssetCountingreportEntry_1.destroy
            end
          end
          index =0;
          params[:datas].each do  |i|
            index+=1;
            #单据体保存检验
            message=message+ Save_Check_Entry("资产盘点单",params,i,index) 
            if  i[1][17].to_s == "0"
              #相对比上次单据体记录，新建的单据体
              @AssetCountingreportEntry_3 = AssetCountingreportEntry.create!(Code: i[1][0],name: i[1][1],Unit: i[1][2],Amount: i[1][3],DisposeAmount: i[1][4],Asset_seat: i[1][5],DisposePrice: i[1][6] ,AssetCountingreport_id: @id,fseq: i[1][9],Addtype_id: i[1][7]);
            else  
              #相对比上次单据体记录，修改的单据体
              @AssetCountingreportEntry_2= AssetCountingreportEntry.find(i[1][17])  
              @AssetCountingreportEntry_2.update(Code: i[1][0],name: i[1][1],Asset_type: i[1][2],Unit: i[1][3],Model: i[1][4],Asset_status: i[1][5],BookQty: i[1][6] ,
                CountQty: i[1][7],Variance: i[1][8],Book_seat: i[1][9],Book_dept:i[1][10],Book_User:i[1][11],Invent_seat:i[1][12],Invent_dept:i[1][13],InventUser:i[1][14],CountDate:i[1][15],
                Headnote:i[1][16],fseq:i[1][18] );
            end
          end
        end
      end
      if(message.lstrip.rstrip!="")  
        #检验不通过，事务回滚！
        render :json  => {code: 202,message: message }
        raise ActiveRecord::Rollback 
      else
        render :json  => {code: 200,message: "保存成功！",id: @id}
      end
    end 
  end
  



  # GET /asset_countingreports
  # GET /asset_countingreports.json
  def index
    @asset_countingreports = AssetCountingreport.all
  end

  # GET /asset_countingreports/1
  # GET /asset_countingreports/1.json
  def show
  end

  # GET /asset_countingreports/new
  def new
    #新增单据，单据状态默认为未审核，单据日期默认为当前日期
    @fseq=0;
    @asset_countingreport = AssetCountingreport.new 
    @asset_countingreport.fbillstatus="未审核"
    @assetcard  =  Assetcard.where("fbillstatus='已审核'");      
    @user = User.all    
    @department = Department.all      
    @asset_countingreport.fdate=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @assetseate = Assetseate.all   
  end

  # GET /asset_countingreports/1/edit
  def edit
    @asset_countingreport_entry  = AssetCountingreportEntry.where( "Asset_Countingreport_id =  ?",  "#{params[:id]}" )   
    @addtype = Addtype.all   
    @user = User.all    
    @department = Department.all      
    @assetcard  =  Assetcard.where("fbillstatus='已审核'");      
    @assetseate = Assetseate.all   
  end
 
  # POST /asset_countingreports
  # POST /asset_countingreports.json
  def create
    @asset_countingreport = AssetCountingreport.new(asset_countingreport_params)

    respond_to do |format|
      if @asset_countingreport.save
        format.html { redirect_to @asset_countingreport, notice: 'Asset countingreport was successfully created.' }
        format.json { render :show, status: :created, location: @asset_countingreport }
      else
        format.html { render :new }
        format.json { render json: @asset_countingreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_countingreports/1
  # PATCH/PUT /asset_countingreports/1.json
  def update
    respond_to do |format|
      if @asset_countingreport.update(asset_countingreport_params)
        format.html { redirect_to @asset_countingreport, notice: 'Asset countingreport was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_countingreport }
      else
        format.html { render :edit }
        format.json { render json: @asset_countingreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_countingreports/1
  # DELETE /asset_countingreports/1.json
  def destroy
    @asset_countingreport.destroy
    respond_to do |format|
      format.html { redirect_to asset_countingreports_url, notice: 'Asset countingreport was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_countingreport
      @asset_countingreport = AssetCountingreport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_countingreport_params
      params.require(:asset_countingreport).permit(:BillNo, :description, :Creator, :CREATEDATE, :Approver, :APPROVEDATE, :fbillstatus, :fdate)
    end
end
