class AssetcardsController < ApplicationController
  before_action :set_assetcard, only: [:show, :edit, :update, :destroy]


 

  def destroy_multiple    
    params["userid"].each do |i| 
      Assetcard.destroy(i)
  end
    respond_to do |format|
      format.html { redirect_to assetcards_url notice: '资产卡片删除成功！.'  }
      format.json { head :no_content }
    end
  end


  # GET /assetcards
  # GET /assetcards.json
  def index 
    
    @q = Assetcard.search(params[:q])      

    if  params[:q].nil?
      @assetcards = Assetcard.all
    else 
      if  params[:q]["name_cont"].lstrip.rstrip==""
        @assetcards = Assetcard.all
      else
        search = params[:q]["search_cont"]
        @assetcards  = Assetcard.where( " #{search}  like  ?",  "%#{params[:q]["name_cont"]}%" ) 
      end
  end
end

  # GET /assetcards/1
  # GET /assetcards/1.json
  def show
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
    @assetcard = Assetcard.new
    @department = Department.all   
    @addtype = Addtype.all   
    @assetseate = Assetseate.all   
    @assetstatus =  Assetstatus.all   
    @assettype = Assettype.all   
    @unit = Unit.all   
    @user = User.all   
    @usestate  =  Usestate.all   
  end

  # GET /assetcards/1/edit
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

  # POST /assetcards
  # POST /assetcards.json
  def create
    @assetcard = Assetcard.new(assetcard_params)

    respond_to do |format|
      if @assetcard.save
        format.html { redirect_to @assetcard, notice: '创建成功！' }
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
      params.require(:assetcard).permit(:assetCode, :assetname, :Assettype_id, :Unit_id, :Amount, :Assetstatus_id, :Addtype_id, :BuyDate, :Usestate_id, :description, :Orgainize_id, :Entrydate, :Price, :Lastprice, :Expectedperiod, :CNOSP, :barcode, :Mould, :Assetseat_id, :Client, :Supplier, :department_id, :Employeeld)
    end
end
