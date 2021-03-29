class UsestatesController < ApplicationController
  before_action :set_usestate, only: [:show, :edit, :update, :destroy]



#返回Json数据
def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
  render json:{code: code, msg: message, count: count,data: data};
end



#获取接口数据
def Get_DataApi
  #获取单据数据
  usestate=Usestate.order(:id);
  #获取单据总数
  total_count=usestate.count
  #分页
  usestate=usestate.page(params[:page]).per(params[:limit])
  #数据转换成Json格式
  data=usestate.as_json;
  #返回Json数据
  api_success(count: total_count,data: data)
end


#返回Json数据
  def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
    render json:{code: code, msg: message, count: count,data: data};
  end




  #获取接口数据
  def Get_DataApi
    #获取单据数据
    usestate=Usestate.order(:id);
    #获取单据总数
    total_count=usestate.count
    #分页
    usestate=usestate.page(params[:page]).per(params[:limit])
    #数据转换成Json格式
    data=usestate.as_json;
    #返回Json数据
    api_success(count: total_count,data: data)
  end

 
 

#更新状态
def  Update_fbillstatus 
  #返回信息
  message=""
  #事务
  ActiveRecord::Base.transaction do  
  @usestate=Usestate.find(params[:id]) 
  if params[:fbillstatus].lstrip.rstrip=="审核"
    @Fbillstatus="已审核"
  else
    @Fbillstatus="未审核"
  end 
  #更新状态检验
  message=message+ Update_Fbillstatus_Check("使用状态",params[:id],params[:fbillstatus]).to_s   
  if  message.lstrip.rstrip=="" 
    #检验通过
    @usestate[0].update(fbillstatus:@Fbillstatus)
    if(params[:fbillstatus].lstrip.rstrip=="审核")
              #审核操作更新审核人、审核日期
      @usestate[0].update(Approver: session[:name],ApproverDate: Time.now.strftime("%Y-%m-%d %H:%M:%S"))  
    end  
    message=params[:fbillstatus].to_s + "成功！"
  end   
      render :json  => {code: 200,message: message}
end 
end
 


#选择资产资料 
  def choose   
    usestate = Usestate.find(params[:usestateid]) 
    @name = usestate.Name
    @id=   params[:id] 
    render 'choose/choose.js.erb'
  end

#忽略
  def export_all 
    @Usestate_all =Usestate.all; 
  end


  #忽略
  def save_multiple  
    params["usestateid"].each do |i| 
      puts i[1].length    
      usestate = Usestate.create!(Usestatecode: i[1][0],Name: i[1][1],Orgainize_id: i[1][2],Description: i[1][3])
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
    params["usestate_id"].each do |i| 
      #删除检验
      result=Delete_Check("使用状态",i);     
      if(result=="")
        #检验通过，成功数+1，删除使用状态
        sussess+=1;
        Usestate.destroy(i)
      else
        #检验不通过，失败数+1
        error+=1;
        message=message+result  
      end 
  end 
  message="删除成功数：#{sussess}\n"+"删除失败数：#{error}\n"+message;
  render :json  => {code: 200,message: message }
end
 



  # GET /usestates
  # GET /usestates.json
  #忽略
  def index
    @q = Usestate.search(params[:q])      


    if  params[:q].nil?
      @usestates=Usestate.order(:id).page(params[:page]).per(10)
    else 
      if  params[:q]["name_cont"].lstrip.rstrip=="" 
        @usestates=Usestate.order(:id).page(params[:page]).per(10)
      else
        search = params[:q]["search_cont"]
        @usestates  = Usestate.where( " #{search}  like  ?",  "%#{params[:q]["name_cont"]}%" ) .page(params[:page]).per(10)
      end
    end   
  end

  # GET /usestates/1
  # GET /usestates/1.json
  def show
  end

  # GET /usestates/new
  def new
    @usestate = Usestate.new
    #单据状态默认为未审核
    @usestate.fbillstatus="未审核"
  end

  # GET /usestates/1/edit
  def edit
  end

  # POST /usestates
  # POST /usestates.json
  def create
    @usestate = Usestate.new(usestate_params)
    @usestate.Creator=session[:name] 
    @usestate.CreateDate=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    respond_to do |format|
      if @usestate.save
        format.html { redirect_to @usestate, notice: '创建成功！.' }
        format.json { render :show, status: :created, location: @usestate }
      else
        format.html { render :new }
        format.json { render json: @usestate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usestates/1
  # PATCH/PUT /usestates/1.json
  def update
    respond_to do |format|
      if @usestate.update(usestate_params)
        format.html { redirect_to @usestate, notice: '修改成功！' }
        format.json { render :show, status: :ok, location: @usestate }
      else
        format.html { render :edit }
        format.json { render json: @usestate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usestates/1
  # DELETE /usestates/1.json
  def destroy
    @usestate.destroy
    respond_to do |format|
      format.html { redirect_to usestates_url, notice: '删除成功！.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usestate
      @usestate = Usestate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def usestate_params
      params.require(:usestate).permit(:Usestatecode, :Name, :Orgainize_id, :Description,:fbillstatus,:Creator,:CreateDate,:Approver,:ApproverDate)
    end
end
