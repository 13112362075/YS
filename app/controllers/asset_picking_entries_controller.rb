class AssetPickingEntriesController < ApplicationController
  before_action :set_asset_picking_entry, only: [:show, :edit, :update, :destroy]

  # GET /asset_picking_entries
  # GET /asset_picking_entries.json
  def index
    @asset_picking_entries = AssetPickingEntry.all
  end

  # GET /asset_picking_entries/1
  # GET /asset_picking_entries/1.json
  def show
  end

  # GET /asset_picking_entries/new
  def new
    @asset_picking_entry = AssetPickingEntry.new
  end

  # GET /asset_picking_entries/1/edit
  def edit
  end

  # POST /asset_picking_entries
  # POST /asset_picking_entries.json
  def create
    @asset_picking_entry = AssetPickingEntry.new(asset_picking_entry_params)

    respond_to do |format|
      if @asset_picking_entry.save
        format.html { redirect_to @asset_picking_entry, notice: 'Asset picking entry was successfully created.' }
        format.json { render :show, status: :created, location: @asset_picking_entry }
      else
        format.html { render :new }
        format.json { render json: @asset_picking_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_picking_entries/1
  # PATCH/PUT /asset_picking_entries/1.json
  def update
    respond_to do |format|
      if @asset_picking_entry.update(asset_picking_entry_params)
        format.html { redirect_to @asset_picking_entry, notice: 'Asset picking entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_picking_entry }
      else
        format.html { render :edit }
        format.json { render json: @asset_picking_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_picking_entries/1
  # DELETE /asset_picking_entries/1.json
  def destroy
    @asset_picking_entry.destroy
    respond_to do |format|
      format.html { redirect_to asset_picking_entries_url, notice: 'Asset picking entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_picking_entry
      @asset_picking_entry = AssetPickingEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_picking_entry_params
      params.require(:asset_picking_entry).permit(:Code, :name, :Asset_type, :Unit, :Picking_Amount, :BackQty, :CanbackQty, :PickingFor, :Asset_seat, :Picking_seat, :FSrcFbillno, :FSrcFseq, :AssetPicking_id,:fseq,:assetstatus,:Employeeld,:Deptment)
    end
end
