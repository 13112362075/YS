class AssetPickingsController < ApplicationController
  before_action :set_asset_picking, only: [:show, :edit, :update, :destroy]

  # GET /asset_pickings
  # GET /asset_pickings.json
  def index
    @asset_pickings = AssetPicking.all
  end

  # GET /asset_pickings/1
  # GET /asset_pickings/1.json
  def show
  end

  # GET /asset_pickings/new
  def new
    @asset_picking = AssetPicking.new
  end

  # GET /asset_pickings/1/edit
  def edit
  end

  # POST /asset_pickings
  # POST /asset_pickings.json
  def create
    @asset_picking = AssetPicking.new(asset_picking_params)

    respond_to do |format|
      if @asset_picking.save
        format.html { redirect_to @asset_picking, notice: 'Asset picking was successfully created.' }
        format.json { render :show, status: :created, location: @asset_picking }
      else
        format.html { render :new }
        format.json { render json: @asset_picking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_pickings/1
  # PATCH/PUT /asset_pickings/1.json
  def update
    respond_to do |format|
      if @asset_picking.update(asset_picking_params)
        format.html { redirect_to @asset_picking, notice: 'Asset picking was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_picking }
      else
        format.html { render :edit }
        format.json { render json: @asset_picking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_pickings/1
  # DELETE /asset_pickings/1.json
  def destroy
    @asset_picking.destroy
    respond_to do |format|
      format.html { redirect_to asset_pickings_url, notice: 'Asset picking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_picking
      @asset_picking = AssetPicking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_picking_params
      params.require(:asset_picking).permit(:FBillno, :Type_of_business, :Picking_Date, :Picking_Dept, :Picking_Employeeld, :Fbillstatus, :Creator, :Approver, :CreateDate, :ApproveDate)
    end
end
