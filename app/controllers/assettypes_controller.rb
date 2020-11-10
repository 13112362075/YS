class AssettypesController < ApplicationController
  before_action :set_assettype, only: [:show, :edit, :update, :destroy]


  def destroy_multiple    
    params["assettype_id"].each do |i| 
      Assettype.destroy(i)
  end
    respond_to do |format|
      format.html { redirect_to assettypes_url notice: '删除成功!'  }
      format.json { head :no_content }
    end
  end
 


  # GET /assettypes
  # GET /assettypes.json
  def index 
    @q = Assettype.search(params[:q])      

    if  params[:q].nil?
      @assettypes = Assettype.all 
    else 
      if  params[:q]["name_cont"].lstrip.rstrip==""
        @assettypes = Assettype.all
      else
        search = params[:q]["search_cont"]
        @assettypes  = Assettype.where( " #{search}  like  ?",  "%#{params[:q]["name_cont"]}%" ) 
      end
    end  
  end

  # GET /assettypes/1
  # GET /assettypes/1.json
  def show
  end

  # GET /assettypes/new
  def new
    @assettype = Assettype.new
  end

  # GET /assettypes/1/edit
  def edit
  end

  # POST /assettypes
  # POST /assettypes.json
  def create
    @assettype = Assettype.new(assettype_params)

    respond_to do |format|
      if @assettype.save
        format.html { redirect_to @assettype, notice: '创建成功！' }
        format.json { render :show, status: :created, location: @assettype }
      else
        format.html { render :new }
        format.json { render json: @assettype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assettypes/1
  # PATCH/PUT /assettypes/1.json
  def update
    respond_to do |format|
      if @assettype.update(assettype_params)
        format.html { redirect_to @assettype, notice: '修改成功！' }
        format.json { render :show, status: :ok, location: @assettype }
      else
        format.html { render :edit }
        format.json { render json: @assettype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assettypes/1
  # DELETE /assettypes/1.json
  def destroy
    @assettype.destroy
    respond_to do |format|
      format.html { redirect_to assettypes_url, notice: '删除成功！' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assettype
      @assettype = Assettype.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assettype_params
      params.require(:assettype).permit(:Assettypecode, :Name, :Orgainize_id, :description)
    end
end
