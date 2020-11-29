class UnitsController < ApplicationController
  before_action :set_unit, only: [:show, :edit, :update, :destroy]


  def export_all
    @unit_all =Unit.all; 
  end


  
  def save_multiple  
    params["unitid"].each do |i| 
      puts i[1].length    
      unit = Unit.create!(Unitcode: i[1][0],name: i[1][1],Unitaccuracy: i[1][2],Roundingtype: i[1][3])
 
    end
  end

  def destroy_multiple    
    params["unit_id"].each do |i| 
      Unit.destroy(i)
  end
    respond_to do |format|
      format.html { redirect_to units_url notice: '删除成功！.'  }
      format.json { head :no_content }
    end
  end


  # GET /units
  # GET /units.json
  def index 
    @q = Unit.search(params[:q])      

    if  params[:q].nil? 
      @units=Unit.order(:id).page(params[:page]).per(10)
    else 
      if  params[:q]["name_cont"].lstrip.rstrip==""
        @units=Unit.order(:id).page(params[:page]).per(10)
      else
        search = params[:q]["search_cont"]
        @units  = Unit.where( " #{search}  like  ?",  "%#{params[:q]["name_cont"]}%" ) .page(params[:page]).per(10)
      end
  end
end

  # GET /units/1
  # GET /units/1.json
  def show
  end

  # GET /units/new
  def new
    @unit = Unit.new
  end

  # GET /units/1/edit
  def edit
  end

  # POST /units
  # POST /units.json
  def create
    @unit = Unit.new(unit_params)

    respond_to do |format|
      if @unit.save
        format.html { redirect_to @unit, notice: '创建成功！.' }
        format.json { render :show, status: :created, location: @unit }
      else
        format.html { render :new }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /units/1
  # PATCH/PUT /units/1.json
  def update
    respond_to do |format|
      if @unit.update(unit_params)
        format.html { redirect_to @unit, notice: '修改成功！.' }
        format.json { render :show, status: :ok, location: @unit }
      else
        format.html { render :edit }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1
  # DELETE /units/1.json
  def destroy
    @unit.destroy
    respond_to do |format|
      format.html { redirect_to units_url, notice: '删除成功！' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit
      @unit = Unit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def unit_params
      params.require(:unit).permit(:Unitcode, :name, :Unitaccuracy, :Roundingtype)
    end
end
