class AssetstatusesController < ApplicationController
  before_action :set_assetstatus, only: [:show, :edit, :update, :destroy]

  def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
    render json:{code: code, msg: message, count: count,data: data};
  end


  def Get_DataApi
    assetstatus=Assetstatus.order(:id);
    total_count=assetstatus.count
    assetstatus=assetstatus.page(params[:page]).per(params[:limit])
    data=assetstatus.as_json;
    api_success(count: total_count,data: data)
  end



  def  Update_fbillstatus 
    message=""
    ActiveRecord::Base.transaction do 
    message=""  
    @assetstatus=Assetstatus.find(params[:id]) 
    if params[:fbillstatus].lstrip.rstrip=="审核"
      @Fbillstatus="已审核"
    else
      @Fbillstatus="未审核"
    end 
    message=message+ Update_Fbillstatus_Check("资产状态",params[:id],params[:fbillstatus]).to_s   
    if  message.lstrip.rstrip==""
      @assetstatus[0].update(fbillstatus:@Fbillstatus)
      if(params[:fbillstatus].lstrip.rstrip=="审核")
        @assetstatus[0].update(Approver: session[:name],ApproverDate: Time.now.strftime("%Y-%m-%d %H:%M:%S"))  
      end  
      message=params[:fbillstatus].to_s + "成功！"
    end   
        render :json  => {code: 200,message: message}
  end 
end



  def choose   
    assetstatus = Assetstatus.find(params[:assetstatusid]) 
    @name = assetstatus.Name
    @id=   params[:id] 
    render 'choose/choose.js.erb'
  end 

  def export_all
    @assetstatus_all =Assetstatus.all; 
  end


  
  def save_multiple   
    params["assetstatuseid"].each do |i| 
      puts i[1].length    
      assetstatus = Assetstatus.create!(Assetstatuscode: i[1][0],Name: i[1][1],Orgainize_id: i[1][2],description: i[1][3])
 
    end
  end


  def destroy_multiple    
    sussess=0;
    error=0;
    message="";
    params["assetstatuse_id"].each do |i| 
      result=Delete_Check("资产状态",i);    
      if(result=="")
        sussess+=1;
        Assetstatus.destroy(i)
      else
        error+=1; 
        message=message+result  
      end 

  end
  message="删除成功数：#{sussess}\n"+"删除失败数：#{error}\n"+message;
  render :json  => {code: 200,message: message }
  end
 

  # GET /assetstatuses
  # GET /assetstatuses.json
  def index 

    @q = Assetstatus.search(params[:q])      

    if  params[:q].nil? 
      @assetstatuses=Assetstatus.order(:id).page(params[:page]).per(10)
    else 
      if  params[:q]["name_cont"].lstrip.rstrip==""
        @assetstatuses=Assetstatus.order(:id).page(params[:page]).per(10)
      else
        search = params[:q]["search_cont"]
        @assetstatuses  = Assetstatus.where( " #{search}  like  ?",  "%#{params[:q]["name_cont"]}%" ).page(params[:page]).per(10)
      end
    end  



  end

  # GET /assetstatuses/1
  # GET /assetstatuses/1.json
  def show
  end

  # GET /assetstatuses/new
  def new
    @assetstatus = Assetstatus.new
    @assetstatus.fbillstatus="未审核"
  end

  # GET /assetstatuses/1/edit
  def edit
  end

  # POST /assetstatuses
  # POST /assetstatuses.json
  def create
    @assetstatus = Assetstatus.new(assetstatus_params)
    @assetstatus.Creator=session[:name] 
    @assetstatus.CreateDate=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    respond_to do |format|
      if @assetstatus.save
        format.html { redirect_to @assetstatus, notice: '创建成功！' }
        format.json { render :show, status: :created, location: @assetstatus }
      else
        format.html { render :new }
        format.json { render json: @assetstatus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assetstatuses/1
  # PATCH/PUT /assetstatuses/1.json
  def update
    respond_to do |format|
      if @assetstatus.update(assetstatus_params)
        format.html { redirect_to @assetstatus, notice: '修改成功！.' }
        format.json { render :show, status: :ok, location: @assetstatus }
      else
        format.html { render :edit }
        format.json { render json: @assetstatus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assetstatuses/1
  # DELETE /assetstatuses/1.json
  def destroy
    @assetstatus.destroy
    respond_to do |format|
      format.html { redirect_to assetstatuses_url, notice: '删除成功！' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assetstatus
      @assetstatus = Assetstatus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assetstatus_params
      params.require(:assetstatus).permit(:Assetstatuscode, :Name, :Orgainize_id, :description,:fbillstatus,:Creator,:CreateDate,:Approver,:ApproverDate)
    end
end
