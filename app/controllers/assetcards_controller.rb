class AssetcardsController < ApplicationController
  before_action :set_assetcard, only: [:show, :edit, :update, :destroy]



  def  Update_Status 
    @IsUpdate="true";
    @id=[];
    @status= params[:Status];
    params[:id_list].each do |i|
   
      if(params[:Status]=="借出")
        @assetcard_by_status=Assetcard.where("assetCode = ?   and  Usestate_id = ?" ,i, "借出");  
        if   @assetcard_by_status.length >0
          @IsUpdate="false";
          @id << i; 
        end
      else
        @assetcard_by_status=Assetcard.where("assetCode = ? and  Usestate_id = ? " ,i, "可用"); 
        if   @assetcard_by_status.length >0
          @IsUpdate="false";
          puts i;
          @id << i; 
        end
      end  
    end  
  if  (@IsUpdate =="true")
    params[:id_list].each do |i|
      @assetcard_by_status=Assetcard.where("assetCode = ? " ,i); 
      @assetcard_by_status.update(Usestate_id:   params[:Status]);
    end
  end
end




  def choose   
    @assetcard = Assetcard.find(params[:assetcardid]) 
    @assetname = @assetcard.assetname
    @assetCode = @assetcard.assetCode
    @Unit_id = @assetcard.Unit_id
    @Amount = @assetcard.Amount
    @department_id = @assetcard.department_id
    @Employeeld = @assetcard.Employeeld
    @Assetseat_id = @assetcard.Assetseat_id 
    @row =params[:row]
    @id=   params[:idlist] 
    @isaddrow=params[:isaddrow]   
    render 'choose/assetcard_choose.js.erb'
  end 


  def export_all 
    @assetcard_all =Assetcard.all; 
  end


  
  def save_multiple  
    params["assetcardid"].each do |i| 
      puts i[1].length    
      assetcard = Assetcard.create!(assetCode: i[1][0],assetname: i[1][1],Assettype_id: i[1][2],Unit_id: i[1][3],Amount: i[1][4], Assetstatus_id: i[1][5],Addtype_id: i[1][6],BuyDate: i[1][7],Usestate_id: i[1][8],description: i[1][9],Orgainize_id: i[1][10],Entrydate: i[1][11],Price: i[1][12],Lastprice: i[1][13],Expectedperiod: i[1][14], CNOSP: i[1][15],barcode: i[1][16],Mould: i[1][17],Assetseat_id: i[1][18],Client: i[1][19], Supplier: i[1][20],department_id: i[1][21],Employeeld: i[1][22])
    end
  end

 

  def destroy_multiple    

    sussess=0;
    error=0;
    message="";
    params["assetcardid"].each do |i| 
      result=Delete_Check("资产卡片",i);    
      if(result=="") 
        sussess+=1;
       Assetcard.destroy(i)
      else
        error+=1; 
        message=message+result  
 
      end 
  end 

      message="删除成功数：#{sussess}\n"+"删除失败数：#{error}\n"+message;
      render :json  => {code: 200,message: message }
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
    puts  @assetcard.attributes.keys
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
      params.require(:assetcard).permit(:assetCode, :assetname, :Assettype_id, :Unit_id, :Amount, :Assetstatus_id, :Addtype_id, :BuyDate, :Usestate_id, :description, :Orgainize_id, :Entrydate, :Price, :Lastprice, :Expectedperiod, :CNOSP, :barcode, :Mould, :Assetseat_id, :Client, :Supplier, :department_id, :Employeeld,:fbillstatus)
    end
end
