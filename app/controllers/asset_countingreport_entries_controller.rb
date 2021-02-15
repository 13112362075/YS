class AssetCountingreportEntriesController < ApplicationController
  before_action :set_asset_countingreport_entry, only: [:show, :edit, :update, :destroy]

  # GET /asset_countingreport_entries
  # GET /asset_countingreport_entries.json
  def index
    @asset_countingreport_entries = AssetCountingreportEntry.all
  end

  # GET /asset_countingreport_entries/1
  # GET /asset_countingreport_entries/1.json
  def show
  end

  # GET /asset_countingreport_entries/new
  def new
    @asset_countingreport_entry = AssetCountingreportEntry.new
  end

  # GET /asset_countingreport_entries/1/edit
  def edit
  end

  # POST /asset_countingreport_entries
  # POST /asset_countingreport_entries.json
  def create
    @asset_countingreport_entry = AssetCountingreportEntry.new(asset_countingreport_entry_params)

    respond_to do |format|
      if @asset_countingreport_entry.save
        format.html { redirect_to @asset_countingreport_entry, notice: 'Asset countingreport entry was successfully created.' }
        format.json { render :show, status: :created, location: @asset_countingreport_entry }
      else
        format.html { render :new }
        format.json { render json: @asset_countingreport_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_countingreport_entries/1
  # PATCH/PUT /asset_countingreport_entries/1.json
  def update
    respond_to do |format|
      if @asset_countingreport_entry.update(asset_countingreport_entry_params)
        format.html { redirect_to @asset_countingreport_entry, notice: 'Asset countingreport entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_countingreport_entry }
      else
        format.html { render :edit }
        format.json { render json: @asset_countingreport_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_countingreport_entries/1
  # DELETE /asset_countingreport_entries/1.json
  def destroy
    @asset_countingreport_entry.destroy
    respond_to do |format|
      format.html { redirect_to asset_countingreport_entries_url, notice: 'Asset countingreport entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_countingreport_entry
      @asset_countingreport_entry = AssetCountingreportEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_countingreport_entry_params
      params.require(:asset_countingreport_entry).permit(:Code, :name, :Asset_type, :Unit, :Model, :Asset_status, :BookQty, :CountQty, :Variance, :Book_seat, :Book_dept, :Book_User, :Invent_seat, :Invent_dept, :InventUser, :CountDate, :Headnote, :fseq, :Asset_Countingreport_id)
    end
end
