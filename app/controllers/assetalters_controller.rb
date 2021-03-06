class AssetaltersController < ApplicationController
  before_action :set_assetalter, only: [:show, :edit, :update, :destroy]
 
#删除
  def destroy_multiple     
    #返回信息
    message=""
    #事务
    ActiveRecord::Base.transaction do 
      params["assetaltersid"].each do |i|  
        #删除检验
        message =message +  Delete_Check("资产变更单",i ).to_s
        if message.lstrip.rstrip ==""  
          #检验通过，删除
          Assetalter.destroy(i) 
        end
      end
      if message.lstrip.rstrip!="" 
        #删除不通过，事务回滚！
        render :json  => {code: 201,message: message  }
        raise ActiveRecord::Rollback 
      else
        render :json  => {code: 200,message: "删除成功！"  }
      end
    end 
  end

#保存
  def  save_all
    #返回信息
    message="" 
    if message.lstrip.rstrip!=""
      #检验不通过
      render :json  => {code: 201,message: message }
      return;
    end
    #检验通过
    if params["id"]=="0"     
          #保存检验
    message=message+Save_Check("资产变更单",comment_params).to_s
      #新单据保存，创建单据
      @assetalter=Assetalter.create!(comment_params)
      #更新创建人、创建日期
      @assetalter.update(Creator:session[:name],Createdate:Time.now.strftime("%Y-%m-%d %H:%M:%S"))
    else
      @assetalter=Assetalter.find(params[:id])
      #单据修改保存
      @assetalter.update(comment_params)
    end
    render :json  => {code: 200,message: "保存成功！",id:@assetalter.id }
  end

#返回Json数据
  def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
    render json:{code: code, msg: message, count: count,data: data};
  end

#获取接口数据
  def Get_DataApi 
    #获取单据数据
    assetalter=Assetalter.order(:id);
    #获取单据总数
    total_count=Assetalter.count
    #分页
    assetalter=Assetalter.page(params[:page]).per(params[:limit])
    #转换成Json
    data=assetalter.as_json;
    #返回数据
    api_success(count: total_count,data: data)
  end





  # GET /assetalters
  # GET /assetalters.json
  def index
    @assetalters = Assetalter.all
  end

  # GET /assetalters/1
  # GET /assetalters/1.json
  def show
  end

  #更新状态
  def    Update_Fbillstatus 
    #返回信息
    message=""; 
      @assetalter=Assetalter.where("id = ?  and fbillstatus = '已审核'" ,params[:id]); 
      if @assetalter.length>0
        message="该单据已经是审核状态，不允许再审核！"
      else
        @assetalter=Assetalter.find(params[:id]); 
        @assetalter.update(fbillstatus:   "已审核" , Approver:   session[:name], Approverdate:Time.now.strftime("%Y-%m-%d %H:%M:%S") );  
        @assetcard=Assetcard.where("assetCode=? " , @assetalter.assetCode);  
        #更新资产卡片数据
        @assetcard[0].update(Assetstatus_id:  @assetalter.Assetstatus_id, Assetseat_id:  @assetalter.Assetseat_id,  Mould:    @assetalter.Mould,  Client:  @assetalter.Client, 
          Supplier:   @assetalter.Supplier, Price:  @assetalter.Price, Expectedperiod:   @assetalter.Expectedperiod,  department_id:  @assetalter.department_id, Employeeld:   @assetalter.Employeeld)
        message="审核成功！"
      end 
    render :json  => {code: 200,message: message }
  end


 #判断是否存在未审核的资产变更单
def Check_IsExist
  @assetcard=Assetcard.find(params[:assetCode])
  @assetalter=Assetalter.where("assetCode = ?  and fbillstatus = '未审核'" ,@assetcard.assetCode); 
  if @assetalter.length>0
    #存在未审核的资产变更单 
    render :json  => {code: 201,message: "存在未审核的资产变更单，不允许再变更！" }
  else
    render :json  => {code: 200,message: "" }
  end
end


  # GET /assetalters/new
  def new 
    #新增单据时，资产卡片数据为改变前、后数据，单据状态为未审核
    @assetalter = Assetalter.new  
    @assetcard=Assetcard.where("id = ? " ,params[:assetcardid]);  
    @assetalter.Fbillno=""; 
    @assetalter.assetCode=@assetcard[0].assetCode
    @assetalter.assetname =@assetcard[0].assetname
    @assetalter.Assettype_id=@assetcard[0].Assettype_id
    @assetalter.Unit_id=@assetcard[0].Unit_id
    @assetalter.Amount=@assetcard[0].Amount
    @assetalter.Assetstatus_id=@assetcard[0].Assetstatus_id
    @assetalter.Addtype_id=@assetcard[0].Addtype_id
    @assetalter.BuyDate=@assetcard[0].BuyDate
    @assetalter.description=@assetcard[0].description
    @assetalter.Orgainize_id=@assetcard[0].Orgainize_id
    @assetalter.Entrydate=@assetcard[0].Entrydate
    @assetalter.Price=@assetcard[0].Price
    @assetalter.Lastprice=@assetcard[0].Lastprice
    @assetalter.Expectedperiod=@assetcard[0].Expectedperiod
    @assetalter.CNOSP=@assetcard[0].CNOSP
    @assetalter.barcode=@assetcard[0].barcode
    @assetalter.Mould=@assetcard[0].Mould
    @assetalter.Assetseat_id=@assetcard[0].Assetseat_id
    @assetalter.Client=@assetcard[0].Client
    @assetalter.Supplier=@assetcard[0].Supplier
    @assetalter.department_id=@assetcard[0].department_id
    @assetalter.Employeeld=@assetcard[0].Employeeld
    @assetalter.assetCode_Old=@assetcard[0].assetCode
    @assetalter.assetname_Old=@assetcard[0].assetname 
    @assetalter.Assettype_id_Old=@assetcard[0].Assettype_id 
    @assetalter.Unit_id_Old=@assetcard[0].Unit_id 
    @assetalter.Amount_Old=@assetcard[0].Amount 
    @assetalter.Assetstatus_id_Old=@assetcard[0].Assetstatus_id 
    @assetalter.Addtype_id_Old=@assetcard[0].Addtype_id 
    @assetalter.BuyDate_Old=@assetcard[0].BuyDate 
    @assetalter.description_Old=@assetcard[0].description 
    @assetalter.Orgainize_id_Old=@assetcard[0].Orgainize_id 
    @assetalter.Entrydate_Old=@assetcard[0].Entrydate 
    @assetalter.Price_Old=@assetcard[0].Price 
    @assetalter.Lastprice_Old=@assetcard[0].Lastprice
    @assetalter.Expectedperiod_Old=@assetcard[0].Expectedperiod 
    @assetalter.CNOSP_Old=@assetcard[0].CNOSP 
    @assetalter.barcode_Old=@assetcard[0].barcode 
    @assetalter.Mould_Old=@assetcard[0].Mould 
    @assetalter.Assetseat_id_Old=@assetcard[0].Assetseat_id 
    @assetalter.Client_Old=@assetcard[0].Client 
    @assetalter.Supplier_Old=@assetcard[0].Supplier 
    @assetalter.department_id_Old=@assetcard[0].department_id 
    @assetalter.Employeeld_Old=@assetcard[0].Employeeld 
    @assetalter.Usestate_id_Old=@assetcard[0].Usestate_id 
    @assetalter.Usestate_id=@assetcard[0].Usestate_id 
    @assetalter.fbillstatus ="未审核"  
    @department = Department.all   
    @addtype = Addtype.all   
    @assetseate = Assetseate.all   
    @assetstatus =  Assetstatus.all   
    @assettype = Assettype.all   
    @unit = Unit.all   
    @user = User.all   
    @usestate  =  Usestate.all   
  end

  # GET /assetalters/1/edit
  def edit
    @department = Department.all   
    @addtype = Addtype.all   
    @assetseate = Assetseate.all   
    @assetstatus =  Assetstatus.all   
    @assettype = Assettype.all   
    @unit = Unit.all   
    @user = User.all   
    @usestate  =  Usestate.all   
  end

 


  # POST /assetalters
  # POST /assetalters.json
  def create 
    @department = Department.all   
    @addtype = Addtype.all   
    @assetseate = Assetseate.all   
    @assetstatus =  Assetstatus.all   
    @assettype = Assettype.all   
    @unit = Unit.all   
    @user = User.all   
    @usestate  =  Usestate.all   
    @assetalter = Assetalter.new(assetalter_params)
    #创建人为当前登录用户
    @assetalter.Creator=session[:name]
    #创建日期为当前日期
    @assetalter.Createdate=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @message=""
    puts "1111"
    respond_to do |format| 
      if(assetalter_params[:id].lstrip.rstrip=="")
        puts "123213213"
        @message=@message+Save_Check("资产变更单",@assetalter)
      end 
      if(@message.lstrip.rstrip=="")
        if @assetalter.save 
          format.html { render :edit, notice: '创建成功' }
          format.json { render :show, status: :created, location: @assetalter }
        else
          format.html { render :new }
          format.json { render json: @assetalter.errors, status: :unprocessable_entity }
        end
      else 
        render 'assetalters/alertmessage.js.erb'
      end 
    end
  end

  # PATCH/PUT /assetalters/1
  # PATCH/PUT /assetalters/1.json
  def update
    @department = Department.all   
    @addtype = Addtype.all   
    @assetseate = Assetseate.all   
    @assetstatus =  Assetstatus.all   
    @assettype = Assettype.all   
    @unit = Unit.all   
    @user = User.all   
    @usestate  =  Usestate.all   
    respond_to do |format|
      if @assetalter.update(assetalter_params)
        format.html { render :edit, notice: '保存成功' }
        format.json { render :show, status: :ok, location: @assetalter }
      else
        format.html { render :edit }
        format.json { render json: @assetalter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assetalters/1
  # DELETE /assetalters/1.json
  def destroy
    @assetalter.destroy
    respond_to do |format|
      format.html { redirect_to assetalters_url, notice: 'Assetalter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assetalter
      @assetalter = Assetalter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assetalter_params
      params.require(:assetalter).permit(:Fbillno, :assetCode, :assetname, :Assettype_id, :Unit_id, :Amount, :Assetstatus_id, :Addtype_id, :BuyDate, :description, :Orgainize_id, :Entrydate, :Price, :Lastprice, :Expectedperiod, :CNOSP, :barcode, :Mould, :Assetseat_id, :Client, :Supplier, :department_id, :Employeeld, :assetCode_Old, :assetname_Old, :Assettype_id_Old, :Unit_id_Old, :Amount_Old, :Assetstatus_id_Old, :Addtype_id_Old, :BuyDate_Old, :description_Old, :Orgainize_id_Old, :Entrydate_Old, :Price_Old, :Lastprice_Old, :Expectedperiod_Old, :CNOSP_Old, :barcode_Old, :Mould_Old, :Assetseat_id_Old, :Client_Old, :Supplier_Old, :department_id_Old, :Employeeld_Old, :fbillstatus, :Creator, :Createdate, :Approver, :Approverdate,:Usestate_id,:Usestate_id_Old)
    end


    def comment_params
      params.require(:datas).permit(:Fbillno, :assetCode, :assetname, :Assettype_id, :Unit_id, :Amount, :Assetstatus_id, :Addtype_id, :BuyDate, :description, :Orgainize_id, :Entrydate, :Price, :Lastprice, :Expectedperiod, :CNOSP, :barcode, :Mould, :Assetseat_id, :Client, :Supplier, :department_id, :Employeeld, :assetCode_Old, :assetname_Old, :Assettype_id_Old, :Unit_id_Old, :Amount_Old, :Assetstatus_id_Old, :Addtype_id_Old, :BuyDate_Old, :description_Old, :Orgainize_id_Old, :Entrydate_Old, :Price_Old, :Lastprice_Old, :Expectedperiod_Old, :CNOSP_Old, :barcode_Old, :Mould_Old, :Assetseat_id_Old, :Client_Old, :Supplier_Old, :department_id_Old, :Employeeld_Old, :fbillstatus, :Creator, :Createdate, :Approver, :Approverdate,:Usestate_id,:Usestate_id_Old)
    end
end
