class AddtypesController < ApplicationController
  before_action :set_addtype, only: [:show, :edit, :update, :destroy]



  def  Update_fbillstatus 
    message=""
    ActiveRecord::Base.transaction do 
    message=""  
    @addtype=Addtype.find(params[:id]) 
    if params[:fbillstatus].lstrip.rstrip=="审核"
      @Fbillstatus="已审核"
    else
      @Fbillstatus="未审核"
    end 
    message=message+ Update_Fbillstatus_Check("变动方式",params[:id],params[:fbillstatus]).to_s   
    if  message.lstrip.rstrip==""
      @addtype[0].update(fbillstatus:@Fbillstatus)
      if(params[:fbillstatus].lstrip.rstrip=="审核")
        @addtype[0].update(Approver: session[:name],ApproverDate: Time.now.strftime("%Y-%m-%d %H:%M:%S"))  
      end  
      message=params[:fbillstatus].to_s + "成功！"
    end   
        render :json  => {code: 200,message: message}
  end 
end







  def choose   
    addtype = Addtype.find(params[:addtypeid]) 
    @name = addtype.Name
    @id=   params[:id]   
    render 'choose/choose.js.erb'
  end 


  def export_all
    @addtype_all =Addtype.all; 
  end


  
  def save_multiple  
    params["addtypeid"].each do |i|   
      addtype = Addtype.create!(Addtypecode: i[1][0],Name: i[1][1],Orgainize_id: i[1][2],Description: i[1][3])
    end
  end





  def destroy_multiple    
    sussess=0;
    error=0;
    message="";
    params["addtype_id"].each do |i| 
      result=Delete_Check("变动方式",i);    
      if(result=="")
        sussess+=1;
        Addtype.destroy(i)
      else
        error+=1;
        message=message+result  
      end 

  end
  message="删除成功数：#{sussess}\n"+"删除失败数：#{error}\n"+message;
  render :json  => {code: 200,message: message }
  end



  # GET /addtypes
  # GET /addtypes.json
  def index 
    @q = Addtype.search(params[:q])      

    if  params[:q].nil? 
      @addtypes=Addtype.order(:id).page(params[:page]).per(10)
    else 
      if  params[:q]["name_cont"].lstrip.rstrip==""
        @addtypes=Addtype.order(:id).page(params[:page]).per(10)
      else
        search = params[:q]["search_cont"]
        @addtypes  = Addtype.where( " #{search}  like  ?",  "%#{params[:q]["name_cont"]}%" ).page(params[:page]).per(10)
      end
    end   
  end

  # GET /addtypes/1
  # GET /addtypes/1.json
  def show
  end

  # GET /addtypes/new
  def new
    @addtype = Addtype.new
    @addtype.fbillstatus="未审核"
  end

  # GET /addtypes/1/edit
  def edit
  end

  # POST /addtypes
  # POST /addtypes.json
  def create
    @addtype = Addtype.new(addtype_params)
    @addtype.Creator=session[:name] 
    @addtype.CreateDate=Time.now.strftime("%Y-%m-%d %H:%M:%S")
    respond_to do |format|
      if @addtype.save
        format.html { redirect_to @addtype, notice: '变动方式创建成功！' }
        format.json { render :show, status: :created, location: @addtype }
      else
        format.html { render :new }
        format.json { render json: @addtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addtypes/1
  # PATCH/PUT /addtypes/1.json
  def update
    respond_to do |format|
      if @addtype.update(addtype_params)
        format.html { redirect_to @addtype, notice: '变动方式修改成功！' }
        format.json { render :show, status: :ok, location: @addtype }
      else
        format.html { render :edit }
        format.json { render json: @addtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addtypes/1
  # DELETE /addtypes/1.json
  def destroy
    @addtype.destroy
    respond_to do |format|
      format.html { redirect_to addtypes_url, notice: '变动方式删除成功！.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_addtype
      @addtype = Addtype.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def addtype_params
      params.require(:addtype).permit(:Addtypecode, :Name, :Orgainize_id, :Description,:fbillstatus,:Creator,:CreateDate,:Approver,:ApproverDate)
    end
end
