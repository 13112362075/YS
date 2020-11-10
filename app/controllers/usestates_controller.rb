class UsestatesController < ApplicationController
  before_action :set_usestate, only: [:show, :edit, :update, :destroy]


  def destroy_multiple    
    params["usestate_id"].each do |i| 
      Usestate.destroy(i)
  end
    respond_to do |format|
      format.html { redirect_to usestates_url notice: '删除成功！.'  }
      format.json { head :no_content }
    end
  end




  # GET /usestates
  # GET /usestates.json
  def index
    @q = Usestate.search(params[:q])      


    if  params[:q].nil?
      @usestates = Usestate.all 
    else 
      if  params[:q]["name_cont"].lstrip.rstrip==""
        @usestates = Usestate.all
      else
        search = params[:q]["search_cont"]
        @usestates  = Usestate.where( " #{search}  like  ?",  "%#{params[:q]["name_cont"]}%" ) 
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
