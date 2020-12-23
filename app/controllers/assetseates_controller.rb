class AssetseatesController < ApplicationController
  before_action :set_assetseate, only: [:show, :edit, :update, :destroy]

  def choose   
    assetseate = Assetseate.find(params[:assetseateid]) 
    @name = assetseate.Name
    @id=   params[:id] 
    render 'choose/choose.js.erb'
  end 

 
  def export_all
    @assetseate_all =Assetseate.all; 
  end


  
  def save_multiple  
    params["assetseateid"].each do |i| 
      puts i[1].length    
      assetseate = Assetseate.create!(Assetseatecode: i[1][0],Name: i[1][1],Orgainize_id: i[1][2],Description: i[1][3])
    
    end
  end

  def destroy_multiple    
    sussess=0;
    error=0;
    message="";
    params["assetseate_id"].each do |i| 
      result=Delete_Check("资产位置",i);     
      if(result=="")
        sussess+=1;
        Assetseate.destroy(i)
      else
        error+=1;
        message=message+result  
      end 
  end 
  message="删除成功数：#{sussess}\n"+"删除失败数：#{error}\n"+message;
  render :json  => {code: 200,message: message }
end


  # GET /assetseates
  # GET /assetseates.json
  def index  
    @q = Assetseate.search(params[:q])      

    if  params[:q].nil? 
      @assetseate=Assetseate.order(:id).page(params[:page]).per(10)
    else 
      if  params[:q]["name_cont"].lstrip.rstrip==""
        @assetseate=Assetseate.order(:id).page(params[:page]).per(10)
      else
        search = params[:q]["search_cont"]
        @assetseate  = Assetseate.where( " #{search}  like  ?",  "%#{params[:q]["name_cont"]}%" ) .page(params[:page]).per(10)
      end
    end   
  end

  # GET /assetseates/1
  # GET /assetseates/1.json 
  def show
  end

  # GET /assetseates/new
  def new
    @assetseate = Assetseate.new
  end

  # GET /assetseates/1/edit
  def edit
  end

  # POST /assetseates
  # POST /assetseates.json
  def create
    @assetseate = Assetseate.new(assetseate_params)

    respond_to do |format|
      if @assetseate.save
        format.html { redirect_to @assetseate, notice: '创建成功！' }
        format.json { render :show, status: :created, location: @assetseate }
      else
        format.html { render :new }
        format.json { render json: @assetseate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assetseates/1
  # PATCH/PUT /assetseates/1.json
  def update
    respond_to do |format|
      if @assetseate.update(assetseate_params)
        format.html { redirect_to @assetseate, notice: '修改成功！' }
        format.json { render :show, status: :ok, location: @assetseate }
      else
        format.html { render :edit }
        format.json { render json: @assetseate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assetseates/1
  # DELETE /assetseates/1.json
  def destroy
    @assetseate.destroy
    respond_to do |format|
      format.html { redirect_to assetseates_url, notice: '删除成功！' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assetseate
      @assetseate = Assetseate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assetseate_params
      params.require(:assetseate).permit(:Assetseatecode, :Name, :Orgainize_id, :Description)
    end
end
