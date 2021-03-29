class AssetPickingsController < ApplicationController
  before_action :set_asset_picking, only: [:show, :edit, :update, :destroy]


 #批量删除
 def destroy_multiple     
  #事务
  ActiveRecord::Base.transaction do
    message="";
    params["asset_pickingsid"].each do |i|  
      #删除检验
      message =message +  Delete_Check("资产领用单",i ).to_s
      if message.lstrip.rstrip =="" 
        #检验通过
        @Entry_by_Asset_recovery_id  = AssetPickingEntry.where( "AssetPicking_id =  ?",  "#{i}")
        @Entry_by_Asset_recovery_id.each do |id|
          @AssetPickingEntry_1 = AssetPickingEntry.find(id.id)  
          @AssetPickingEntry_1.destroy
        end 
        AssetPicking.destroy(i) 
      end
    end 
    if message.lstrip.rstrip!=""
      #检验不通过，事务回滚！
      render :json  => {code: 201,message: message }
      raise ActiveRecord::Rollback 
    else
      render :json  => {code: 200,message: "删除成功！" }
    end
  end
end

  

 #返回Json数据
  def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
    render json:{code: code, msg: message, count: count,data: data};
  end



#获取接口数据
def Get_DataApi
  #获取单据数据
  assetPicking=AssetPicking.order(:id);
  #获取单据数据数量
  total_count=assetPicking.count
  #分页
  assetPicking=assetPicking.page(params[:page]).per(params[:limit])
  #转换成Json数据
  data=assetPicking.as_json;
  #返回Json数据
  api_success(count: total_count,data: data)
end



 



#判断是否能下推
def Check_IsPush
  sql="select a.* from asset_picking_entries a  inner join asset_pickings   b  on  b.id=a.AssetPicking_id left  join asset_picking_entries c on c.FSrcFbillno=b.FBillno and c.FSrcFseq  = a.fseq  where  c.id  is   null and   b.id=" + params[:id]
  @assetPickingEntry =AssetPickingEntry.find_by_sql (sql) 
  if @assetPickingEntry.length==0
    #没有可以下推的单据体
    render :json  => {code: 201,message: "不允许下推条件，请检查单据体是否已经下推！"}
  else
    render :json  => {code: 200,message: ""}
  end
end


#修改单据状态
  def Update_fbillstatus  
    #返回信息
    message=""
    #事务
    ActiveRecord::Base.transaction do 
      @assetPicking=AssetPicking.find(params[:id]) 
      if params[:fbillstatus]=="审核"
        @Fbillstatus="已审核"
      else
        @Fbillstatus="未审核"
      end 
      #修改状态检验
      message=message+ Update_Fbillstatus_Check("资产领用单",params[:id],params[:fbillstatus]).to_s  
      if  message.lstrip.rstrip==""
        #检验通过，更新状态
        @assetPicking.update(Fbillstatus:@Fbillstatus)
        if(params[:fbillstatus]=="审核")
          #审核操作，更新审核人、审核日期
          @assetPicking.update(Approver: session[:name],ApproveDate: Time.now.strftime("%Y-%m-%d %H:%M:%S"))
        end
        message=params[:fbillstatus].to_s + "成功！"
      end 
    end 
      render :json  => {code: 200,message: message,id: @id}
  end

  #保存
def  save_all
  #返回信息
  message=""   
  #事务
  ActiveRecord::Base.transaction do
    @id=0;
    if params["id"]==""  
      #单据新增保存
      #单据头保存检验
      message = message + Save_Check("资产领用单",params).to_s
      if message.lstrip.rstrip==""
        #检验通过
        #创建单据体
        @AssetPicking = AssetPicking.create!(FBillno:params["FBillno"],Picking_Date: params["Picking_Date"],Picking_Dept: params["Picking_Dept"],Type_of_business:params["Type_of_business"],Picking_Employeeld:params["Picking_Employeeld"],Creator: session[:name],Fbillstatus: '未审核', CreateDate: Time.now.strftime("%Y-%m-%d %H:%M:%S"));
        @id=@AssetPicking.id
        index =0; 
        params["datas"].each do |i| 
          index+=1;
          #单据体保存检验
          message=message+Save_Check_Entry("资产领用单",params,i,index) 
          #如果资产位置等于双击选择资产位置则置空
          if i[1][12].lstrip.rstrip =="双击选择资产位置"
            i[1][12]="";
          end
          #创建单据体
          @AssetPickingEntry = AssetPickingEntry.create!(Code: i[1][0],name: i[1][1],Asset_type: i[1][2],Unit: i[1][3],Picking_Amount: i[1][4],BackQty: i[1][5],CanbackQty: i[1][6],assetstatus: i[1][7],PickingFor: i[1][8],Deptment:i[1][9],Employeeld: i[1][10],Asset_seat: i[1][11],Picking_seat: i[1][12] ,FSrcFbillno: i[1][13],FSrcFseq:i[1][14],AssetPicking_id: @id,fseq: i[1][16]);
          
        end
      end
    else
      #单据修改保存
      @id=params["id"];  
      #单据体保存检验
      message = message + Save_Check("资产领用单",params ).to_s 
      @AssetPicking= AssetPicking.find_by(id: @id) 
      if message.lstrip.rstrip=="" 
        #检验通过
        #更新单据头
        @AssetPicking.update(FBillno:params["FBillno"],Picking_Date: params["Picking_Date"],Picking_Dept: params["Picking_Dept"],Type_of_business:params["Type_of_business"],Picking_Employeeld:params["Picking_Employeeld"]);
        @AssetPickingEntry1  = AssetPickingEntry.where( "AssetPicking_id =  ?",   @id)
        @AssetPickingEntry1.each do  |id| 
          if  !params[:array_id].to_a.include?(id.id.to_s)
            #相对比保存以前的单据体记录，删除单据体记录
            @AssetPickingEntry_1 = AssetPickingEntry.find(id.id) 
            @assetcard=Assetcard.where("Code =  ?",  @AssetPickingEntry_1. Code)#2021-1-14 阿斌修改，删除的过程中，修改状态
            #@assetcard.update(Usestate_id: "可用")#2021-1-14 阿斌修改，删除的过程中，修改状态  
            @AssetPickingEntry_1.destroy
          end
        end
        index =0;
        params[:datas].each do  |i|
          index+=1;
          #单据体保存检验
          message=message+ Save_Check_Entry("资产领用单",params,i,index) 
          if  i[1][15].to_s == "0"
                          #相对比上一次，新增单据体记录
                          #资产位置等于双击选择资产位置则置空
            if i[1][12].lstrip.rstrip =="双击选择资产位置"
              i[1][12]="";
            end
            @AssetPickingEntry_3 = AssetPickingEntry.create!(Code: i[1][0],name: i[1][1],Asset_type: i[1][2],Unit: i[1][3],Picking_Amount: i[1][4],BackQty: i[1][5],CanbackQty: i[1][6],assetstatus: i[1][7],PickingFor: i[1][8],Deptment:i[1][9],Employeeld: i[1][10],Asset_seat: i[1][11],Picking_seat: i[1][12] ,FSrcFbillno: i[1][13],FSrcFseq:i[1][14],AssetPicking_id: @id,fseq: i[1][16]);
          else 
                          #相对比上一次，更新单据体记录
            @AssetPickingEntry_2= AssetPickingEntry.find(i[1][15]) 
            #资产位置等于双击选择资产位置则置空
            if i[1][12].lstrip.rstrip =="双击选择资产位置"
              i[1][12]="";
            end
            #更新单据体信息
            @AssetPickingEntry_2.update(Code: i[1][0],name: i[1][1],Asset_type: i[1][2],Unit: i[1][3],Picking_Amount: i[1][4],BackQty: i[1][5],CanbackQty: i[1][6],assetstatus: i[1][7],PickingFor: i[1][8],Deptment:i[1][9],Employeeld: i[1][10],Asset_seat: i[1][11],Picking_seat: i[1][12] ,FSrcFbillno: i[1][13],FSrcFseq:i[1][14],AssetPicking_id: @id,fseq: i[1][16]);
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


  # GET /asset_pickings
  # GET /asset_pickings.json
  def index
    @asset_pickings = AssetPicking.all
  end

  # GET /asset_pickings/1
  # GET /asset_pickings/1.json
  def show
  end

  # GET /asset_pickings/new
  def new 
    
    @asset_picking = AssetPicking.new  
    #新增单据时， 根据是否有参数，如果有，则业务类型为退回，反之为领用
    if (!params.include? 'id')
      @asset_picking.Type_of_business="领用"
    else
      #业务类型为退回，退回部门为上游单据领用部门、 退回人为领用人
      @asset_picking_old=AssetPicking.find(params[:id]) 
      @asset_picking.Type_of_business="退回" 
      @asset_picking.Picking_Dept=@asset_picking_old.Picking_Dept
      @asset_picking.Picking_Employeeld=@asset_picking_old.Picking_Employeeld 
      #@assetPickingEntry  = AssetPickingEntry.where( "AssetPicking_id =  ?", params[:id])   
      sql="select a.* from asset_picking_entries a  inner join asset_pickings   b  on  b.id=a.AssetPicking_id left  join asset_picking_entries c on c.FSrcFbillno=b.FBillno and c.FSrcFseq  = a.fseq  where  c.id  is   null and   b.id=" + params[:id]
      @assetPickingEntry =AssetPickingEntry.find_by_sql (sql) 
      @seq=0
      @assetPickingEntry.each do |i|    
        @seq+=1;
        #获取源单类型
        i.FSrcFbillno=@asset_picking_old.FBillno 
        @assetPickingEntry_old=AssetPickingEntry.find(i.id)   
        #获取源单行号
        i.FSrcFseq=@assetPickingEntry_old.fseq
        #获取退回数量
        i.BackQty=@assetPickingEntry_old.CanbackQty
        #获取行号
        i.fseq=@seq
      end
    end
    #单据日期为当前日期，单据状态默认为未审核
    @asset_picking.Fbillstatus="未审核"
    @asset_picking.Picking_Date=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @assetcard  =  Assetcard.where("Usestate_id='可用'  and fbillstatus ='已审核' ");    
    @user = User.all   
    @department = Department.all      
    @assetseate = Assetseate.all   
  end

  # GET /asset_pickings/1/edit
  def edit 
    @assetPickingEntry  = AssetPickingEntry.where( "AssetPicking_id =  ?",  "#{params[:id]}" )   
    @assetcard  =  Assetcard.where("Usestate_id='可用'  and fbillstatus ='已审核' ");    
    @user = User.all   
    @department = Department.all    
    @assetseate = Assetseate.all   
  end

  # POST /asset_pickings
  # POST /asset_pickings.json
  def create
    @asset_picking = AssetPicking.new(asset_picking_params) 
    respond_to do |format|
      if @asset_picking.save
        format.html { redirect_to @asset_picking, notice: 'Asset picking was successfully created.' }
        format.json { render :show, status: :created, location: @asset_picking }
      else
        format.html { render :new }
        format.json { render json: @asset_picking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_pickings/1
  # PATCH/PUT /asset_pickings/1.json
  def update
    respond_to do |format|
      if @asset_picking.update(asset_picking_params)
        format.html { redirect_to @asset_picking, notice: 'Asset picking was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_picking }
      else
        format.html { render :edit }
        format.json { render json: @asset_picking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_pickings/1
  # DELETE /asset_pickings/1.json
  def destroy
    @asset_picking.destroy
    respond_to do |format|
      format.html { redirect_to asset_pickings_url, notice: 'Asset picking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_picking
      @asset_picking = AssetPicking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_picking_params
      params.require(:asset_picking).permit(:FBillno, :Type_of_business, :Picking_Date, :Picking_Dept, :Picking_Employeeld, :Fbillstatus, :Creator, :Approver, :CreateDate, :ApproveDate)
    end
end
