class AssetRecoveriesController < ApplicationController
  before_action :set_asset_recovery, only: [:show, :edit, :update, :destroy]

  # GET /asset_recoveries
  # GET /asset_recoveries.json
  def index
    @asset_recoveries = AssetRecovery.all
  end

  # GET /asset_recoveries/1
  # GET /asset_recoveries/1.json
  def show
  end

  # GET /asset_recoveries/new
  def new
    @asset_recovery = AssetRecovery.new
    @entry = AssetRecoveryEntry.new
  end

  # GET /asset_recoveries/1/edit
  def edit
  end

  # POST /asset_recoveries
  # POST /asset_recoveries.json
  def create
    @asset_recovery = AssetRecovery.new(asset_recovery_params)

    respond_to do |format|
      if @asset_recovery.save
        format.html { redirect_to @asset_recovery, notice: 'Asset recovery was successfully created.' }
        format.json { render :show, status: :created, location: @asset_recovery }
      else
        format.html { render :new }
        format.json { render json: @asset_recovery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_recoveries/1
  # PATCH/PUT /asset_recoveries/1.json
  def update
    respond_to do |format|
      if @asset_recovery.update(asset_recovery_params)
        format.html { redirect_to @asset_recovery, notice: 'Asset recovery was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_recovery }
      else
        format.html { render :edit }
        format.json { render json: @asset_recovery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_recoveries/1
  # DELETE /asset_recoveries/1.json
  def destroy
    @asset_recovery.destroy
    respond_to do |format|
      format.html { redirect_to asset_recoveries_url, notice: 'Asset recovery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_recovery
      @asset_recovery = AssetRecovery.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_recovery_params
      params.require(:asset_recovery).permit(:Documentnumber, :Type_of_business, :Requisition_Date)
    end
end
