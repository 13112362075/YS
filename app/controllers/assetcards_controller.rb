class AssetcardsController < ApplicationController
  before_action :set_assetcard, only: [:show, :edit, :update, :destroy]


  def export_all
    puts "1";
    @assetcard_all =Assetcard.all; 
  end


  
  def save_multiple  
    params["assetcardid"].each do |i| 
      puts i[1].length    
      assetcard = Assetcard.create!(assetCode: i[1][0],assetname: i[1][1],Assettype_id: i[1][2],Unit_id: i[1][3],Amount: i[1][4], Assetstatus_id: i[1][5],Addtype_id: i[1][6],BuyDate: i[1][7],Usestate_id: i[1][8],description: i[1][9],Orgainize_id: i[1][10],Entrydate: i[1][11],Price: i[1][12],Lastprice: i[1][13],Expectedperiod: i[1][14], CNOSP: i[1][15],barcode: i[1][16],Mould: i[1][17],Assetseat_id: i[1][18],Client: i[1][19], Supplier: i[1][20],department_id: i[1][21],Employeeld: i[1][22])
 
    end
  end

 

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
      @assetcards=Assetcard.order(:id).page(params[:page]).per(10)
    else 
      if  params[:q]["name_cont"].lstrip.rstrip==""
        @assetcards=Assetcard.order(:id).page(params[:page]).per(10)
      else
        search = params[:q]["search_cont"]
        @assetcards  = Assetcard.where( " #{search}  like  ?",  "%#{params[:q]["name_cont"]}%" ) .page(params[:page]).per(10)
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
