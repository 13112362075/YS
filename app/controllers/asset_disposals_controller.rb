class AssetDisposalsController < ApplicationController
  before_action :set_asset_disposal, only: [:show, :edit, :update, :destroy]

  # GET /asset_disposals
  # GET /asset_disposals.json
  def index
    @asset_disposals = AssetDisposal.all
  end

  # GET /asset_disposals/1
  # GET /asset_disposals/1.json
  def show
  end

  # GET /asset_disposals/new
  def new
    @asset_disposal = AssetDisposal.new
  end

  # GET /asset_disposals/1/edit
  def edit
  end

  # POST /asset_disposals
  # POST /asset_disposals.json
  def create
    @asset_disposal = AssetDisposal.new(asset_disposal_params)

    respond_to do |format|
      if @asset_disposal.save
        format.html { redirect_to @asset_disposal, notice: 'Asset disposal was successfully created.' }
        format.json { render :show, status: :created, location: @asset_disposal }
      else
        format.html { render :new }
        format.json { render json: @asset_disposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_disposals/1
  # PATCH/PUT /asset_disposals/1.json
  def update
    respond_to do |format|
      if @asset_disposal.update(asset_disposal_params)
        format.html { redirect_to @asset_disposal, notice: 'Asset disposal was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_disposal }
      else
        format.html { render :edit }
        format.json { render json: @asset_disposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_disposals/1
  # DELETE /asset_disposals/1.json
  def destroy
    @asset_disposal.destroy
    respond_to do |format|
      format.html { redirect_to asset_disposals_url, notice: 'Asset disposal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_disposal
      @asset_disposal = AssetDisposal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_disposal_params
      params.require(:asset_disposal).permit(:FBillno, :DisposeDate, :Disposemethod, :DisposeReason, :Fbillstatus, :Creator, :Approver, :CreateDate, :ApproveDate)
    end
end
