class AddtypesController < ApplicationController
  before_action :set_addtype, only: [:show, :edit, :update, :destroy]




  def export_all
    @addtype_all =Addtype.all; 
  end


  
  def save_multiple  
    params["addtypeid"].each do |i| 
      puts i[1].length    
      addtype = Addtype.create!(Addtypecode: i[1][0],Name: i[1][1],Orgainize_id: i[1][2],Description: i[1][3])
    end
  end





  def destroy_multiple    
    params["addtype_id"].each do |i| 
      Addtype.destroy(i)
  end
    respond_to do |format|
      format.html { redirect_to addtypes_url notice: '部门删除成功！.'  }
      format.json { head :no_content }
    end
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
  end

  # GET /addtypes/1/edit
  def edit
  end

  # POST /addtypes
  # POST /addtypes.json
  def create
    @addtype = Addtype.new(addtype_params)

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
      params.require(:addtype).permit(:Addtypecode, :Name, :Orgainize_id, :Description)
    end
end
