class AssetcardsController < ApplicationController
  before_action :set_assetcard, only: [:show, :edit, :update, :destroy]
 
 
 

#更新单据状态 
def  Update_Fbillstatus 
  if  params[:fbillstatus].lstrip.rstrip=='反审核'
    @status='未审核'
  else
    @status='已审核'
  end
  #返回信息
  message="";
  params[:id].each do |i| 
    @assetcard_by_id=Assetcard.where("id = ?   and  fbillstatus = ?" ,i,  @status);   
    if @assetcard_by_id.length>0 
      #不允许重复操作
      message=message+"资产卡片编码为："+ @assetcard_by_id[0].assetCode+params[:fbillstatus].lstrip.rstrip+"失败！已经是"+ @status+"状态，不允许"+ params[:fbillstatus]+"\r\n"
    else    
      @assetcard_by_status=Assetcard.where("id = ? " ,i);  
      if Update_Fbillstatus_Check("资产卡片", i,params[:fbillstatus].lstrip.rstrip).to_s .lstrip.lstrip==""
        #操作成功！
        message=message+"资产卡片编码为："+ @assetcard_by_status[0].assetCode+"  "+ params[:fbillstatus].lstrip.rstrip+"成功!\r\n";  
        @assetcard_by_status.update(fbillstatus:   @status);  
        if params[:fbillstatus].lstrip.rstrip=="审核"
          #审核操作更新审核人、审核日期
          @assetcard_by_status.update(Approver:   session[:name],Approverdate:Time.now.strftime("%Y-%m-%d %H:%M:%S"));  
        end
      else
        #审核检验
        message=message+Update_Fbillstatus_Check("资产卡片", i,params[:fbillstatus].lstrip.rstrip).to_s  
      end 
    end
  end
  render :json  => {code: 200,message: message }
end 

#更新数据状态
  def  Update_Status 
    @IsUpdate="true";
    @id=[];
    if(params[:Status]=="归还")
      #归还操作，更新为可用状态
      @status="可用"
    else
      @status= params[:Status];
    end 
    params[:id_list].each do |i| 
      if(params[:Status]=="借出")
        #借出操作，更新资产状态为借出状态
        @assetcard_by_status=Assetcard.where("assetCode = ?   and  Usestate_id = ?" ,i, "借出");  
        if   @assetcard_by_status.length >0
          @IsUpdate="false";
          @id << i; 
        end
      else
        #归还操作，更新资产状态为可用状态
        @assetcard_by_status=Assetcard.where("assetCode = ? and  Usestate_id = ? " ,i, "可用"); 
        if   @assetcard_by_status.length >0
          @IsUpdate="false"; 
          @id << i; 
        end
      end  
    end  


    #2021/1/14 阿斌修改，直接修改状态，不考虑是否借出可用，直接修改
  # if  (@IsUpdate =="true")
  #   params[:id_list].each do |i|
  #     @assetcard_by_status=Assetcard.where("assetCode = ? " ,i); 
  #     @assetcard_by_status.update(Usestate_id:   @status);
  #   end
  # end
  params[:id_list].each do |i|
    @assetcard_by_status=Assetcard.where("assetCode = ? " ,i); 
    @assetcard_by_status.update(Usestate_id:   @status); 
    Update_datas(params[:type],params,@status);

  end
      #2021/1/14 阿斌修改，直接修改状态，不考虑是否借出可用，直接修改
end

#基础资料选择（单据头）
def choose_single
    @assetCodeid= params[:assetCode]
    @assetcard = Assetcard.find(params[:id])   
    @assetCode= @assetcard.assetCode
    render 'choose/assetcard_choose_single.js.erb'
end

#基础资料选择（单据体）
  def choose     
    @FbillnoType=params[:type]
    @assetcard = Assetcard.find(params[:assetcardid])   
    @assetname = @assetcard.assetname
    @assetCode = @assetcard.assetCode
    @Unit_id = @assetcard.Unit_id
    @Amount = @assetcard.Amount
    @Mould = @assetcard.Mould
    @department_id = @assetcard.department_id
    @Assetstatus_id = @assetcard.Assetstatus_id
    @Employeeld = @assetcard.Employeeld
    @Assetseat_id = @assetcard.Assetseat_id 
    @Addtype_id =@assetcard.Addtype_id
    @Assettype_id =@assetcard.Assettype_id
    @Usestate_id =@assetcard.Usestate_id
    @Mould =@assetcard.Mould 
    @Price = @assetcard.Price 
    @row =params[:row]
    @id=   params[:idlist] 
    @isaddrow=params[:isaddrow]      
    render 'choose/assetcard_choose.js.erb'
  end 

#忽略
  def export_all 
    @assetcard_all =Assetcard.all; 
  end


  #忽略
  def save_multiple  
    ActiveRecord::Base.transaction do 
    params["assetcardid"].each do |i|  
      assetcard = Assetcard.create!(assetCode: i[1][0],assetname: i[1][1],Assettype_id: i[1][2],Unit_id: i[1][3],Amount: i[1][4], Assetstatus_id: i[1][5],Addtype_id: i[1][6],BuyDate: i[1][7],Usestate_id: i[1][8],description: i[1][9],Orgainize_id: i[1][10],Entrydate: i[1][11],Price: i[1][12],Lastprice: i[1][13],Expectedperiod: i[1][14], CNOSP: i[1][15],barcode: i[1][16],Mould: i[1][17],Assetseat_id: i[1][18],Client: i[1][19], Supplier: i[1][20],department_id: i[1][21],Employeeld: i[1][22])
    end
  end
end

 
#删除
  def destroy_multiple     
    #成功数
    sussess=0;
    #失败数
    error=0; 
    #返回信息
    message="";
    params["assetcardid"].each do |i| 
      #删除检验
      result=Delete_Check("资产卡片",i);    
      if(result=="") 
        #通过检验，成功数+1，删除资产卡片
        sussess+=1;
       Assetcard.destroy(i)
      else
        #检验不通过，失败数+1
        error+=1; 
        message=message+result   
      end 
  end 

      message="删除成功数：#{sussess}\n"+"删除失败数：#{error}\n"+message;
      render :json  => {code: 200,message: message }
  end


  # GET /assetcards
  # GET /assetcards.json
  #忽略
  def index 
    
    @q = Assetcard.search(params[:q])       
    if  params[:q].nil? 
      @assetcards=Assetcard.order(:id).page(params[:page]).per(10)
    else 
      if  params[:q]["name_cont"].lstrip.rstrip==""
        @assetcards=Assetcard.order(:id).page(params[:page]).per(10)
      else
        search = params[:q]["search_cont"]
        @assetcards  = Assetcard.where( " #{search}  like  ?",  "%#{params[:q]["name_cont"]}%" ) .page(params[:page]).per(10)
      end
  end
  # @assetcards.each do |i|
  #   @assetcards_by_id =Assetcard.find(i.id);
  #   @assetcards_by_id.update(Creator:   session[:name],Createdate:Time.now.strftime("%Y-%m-%d %H:%M:%S") );  
  # end
 
end

  # GET /assetcards/1
  # GET /assetcards/1.json
  def show
    @assetcard=Assetcard.find(params[:id]);
    @assetalter = Assetalter.where("assetCode=? and fbillstatus= '已审核' ", @assetcard.assetCode)
    @department = Department.all   
    @addtype = Addtype.all   
    @assetseate = Assetseate.all   
    @assetstatus =  Assetstatus.all   
    @assettype = Assettype.all   
    @unit = Unit.all   
    @user = User.all   
    @usestate  =  Usestate.all   
  end 

  # GET /assetcards/new
  def new 

    @assetalter = Assetalter.all 
    @assetalters = Assetalter.all
    @assetcard = Assetcard.new
    @assetcard.fbillstatus="未审核"
    @assetcard.Entrydate=Time.now.strftime("%Y-%m-%d %H:%M:%S") 
    @department = Department.all   
    @addtype = Addtype.all   
    @assetseate = Assetseate.all   
    @assetstatus =  Assetstatus.all   
    @assettype = Assettype.all   
    @unit = Unit.all   
    @user = User.all   
    @usestate  =  Usestate.all    

    if(params.include?"Assettype_id")
      if params[:Assettype_id].lstrip.rstrip!="资产类型-列表" 
        @assetcard.Assettype_id= params[:Assettype_id]
      end
    end   
  end

  # GET /assetcards/1/edit
  def edit 
    IsRresh(); 
    @assetcard=Assetcard.find(params[:id]);
    @assetalter = Assetalter.where("assetCode=? and fbillstatus= '已审核' ", @assetcard.assetCode) 
    @department = Department.all   
    @addtype = Addtype.all   
    @assetseate = Assetseate.all   
    @assetstatus =  Assetstatus.all   
    @assettype = Assettype.all   
    @unit = Unit.all   
    @user = User.all   
    @usestate  =  Usestate.all   
  end

  # POST /assetcards
  # POST /assetcards.json
  def create
    @assetalter = Assetalter.all 
    @department = Department.all   
    @addtype = Addtype.all   
    @assetseate = Assetseate.all   
    @assetstatus =  Assetstatus.all   
    @assettype = Assettype.all   
    @unit = Unit.all   
    @user = User.all   
    @usestate  =  Usestate.all   
    @assetcard = Assetcard.new(assetcard_params) 
    #创建人为当前用户，创建日期为当前日期
    @assetcard.Creator=session[:name] 
    @assetcard.Createdate= Time.now.strftime("%Y-%m-%d %H:%M:%S") 
    respond_to do |format|
      if @assetcard.save
        format.html { redirect_to   @assetcard, notice: '创建成功！' }
        format.json { render :show, status: :created, location: @assetcard }
      else
        format.html { render :new }
        format.json { render json: @assetcard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assetcards/1
  # PATCH/PUT /assetcards/1.json
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
      if @assetcard.update(assetcard_params)
        format.html { redirect_to @assetcard, notice: '修改成功！' }
        format.json { render :show, status: :ok, location: @assetcard }
      else
        format.html { render :edit }
        format.json { render json: @assetcard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assetcards/1
  # DELETE /assetcards/1.json
  def destroy
    @assetcard.destroy
    respond_to do |format|
      format.html { redirect_to assetcards_url, notice: 'Assetcard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assetcard
      @assetcard = Assetcard.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assetcard_params
      params.require(:assetcard).permit(:assetCode, :assetname, :Assettype_id, :Unit_id, :Amount, :Assetstatus_id, :Addtype_id, :BuyDate, :Usestate_id, :description, :Orgainize_id, :Entrydate, :Price, :Lastprice, :Expectedperiod, :CNOSP, :barcode, :Mould, :Assetseat_id, :Client, :Supplier, :department_id, :Employeeld,:fbillstatus,:Creator,:Createdate,:Approver,:Approverdate)
    end
end
