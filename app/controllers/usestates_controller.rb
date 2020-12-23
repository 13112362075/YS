class UsestatesController < ApplicationController
  before_action :set_usestate, only: [:show, :edit, :update, :destroy]

  def choose   
    usestate = Usestate.find(params[:usestateid]) 
    @name = usestate.Name
    @id=   params[:id] 
    render 'choose/choose.js.erb'
  end


  def export_all 
    @Usestate_all =Usestate.all; 
  end


  
  def save_multiple  
    params["usestateid"].each do |i| 
      puts i[1].length    
      usestate = Usestate.create!(Usestatecode: i[1][0],Name: i[1][1],Orgainize_id: i[1][2],Description: i[1][3])
    end
  end

  def destroy_multiple    
    sussess=0;
    error=0;
    message="";
    
    params["usestate_id"].each do |i|  
      result=Delete_Check("使用状态",i);    
      puts "1"
      if(result=="")
        sussess+=1;
        Usestate.destroy(i)
      else
        error+=1; 
        message=message+result  
      end 
  end
  message="删除成功数：#{sussess}\n"+"删除失败数：#{error}\n"+message;
  render :json  => {code: 200,message: message }
  end




  # GET /usestates
  # GET /usestates.json
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
  end

  # GET /usestates/1/edit
  def edit
  end

  # POST /usestates
  # POST /usestates.json
  def create
    @usestate = Usestate.new(usestate_params)

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
      params.require(:usestate).permit(:Usestatecode, :Name, :Orgainize_id, :Description)
    end
end
