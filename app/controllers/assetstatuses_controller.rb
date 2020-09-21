class AssetstatusesController < ApplicationController
  before_action :set_assetstatus, only: [:show, :edit, :update, :destroy]

  # GET /assetstatuses
  # GET /assetstatuses.json
  def index
    @assetstatuses = Assetstatus.all
  end

  # GET /assetstatuses/1
  # GET /assetstatuses/1.json
  def show
  end

  # GET /assetstatuses/new
  def new
    @assetstatus = Assetstatus.new
  end

  # GET /assetstatuses/1/edit
  def edit
  end

  # POST /assetstatuses
  # POST /assetstatuses.json
  def create
    @assetstatus = Assetstatus.new(assetstatus_params)

    respond_to do |format|
      if @assetstatus.save
        format.html { redirect_to @assetstatus, notice: 'Assetstatus was successfully created.' }
        format.json { render :show, status: :created, location: @assetstatus }
      else
        format.html { render :new }
        format.json { render json: @assetstatus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assetstatuses/1
  # PATCH/PUT /assetstatuses/1.json
  def update
    respond_to do |format|
      if @assetstatus.update(assetstatus_params)
        format.html { redirect_to @assetstatus, notice: 'Assetstatus was successfully updated.' }
        format.json { render :show, status: :ok, location: @assetstatus }
      else
        format.html { render :edit }
        format.json { render json: @assetstatus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assetstatuses/1
  # DELETE /assetstatuses/1.json
  def destroy
    @assetstatus.destroy
    respond_to do |format|
      format.html { redirect_to assetstatuses_url, notice: 'Assetstatus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assetstatus
      @assetstatus = Assetstatus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assetstatus_params
      params.require(:assetstatus).permit(:Assetstatuscode, :Name, :Orgainize_id, :description)
    end
end
