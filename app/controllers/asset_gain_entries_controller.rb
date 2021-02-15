class AssetGainEntriesController < ApplicationController
  before_action :set_asset_gain_entry, only: [:show, :edit, :update, :destroy]

  # GET /asset_gain_entries
  # GET /asset_gain_entries.json
  def index
    @asset_gain_entries = AssetGainEntry.all
  end

  # GET /asset_gain_entries/1
  # GET /asset_gain_entries/1.json
  def show
  end

  # GET /asset_gain_entries/new
  def new
    @asset_gain_entry = AssetGainEntry.new
  end

  # GET /asset_gain_entries/1/edit
  def edit
  end

  # POST /asset_gain_entries
  # POST /asset_gain_entries.json
  def create
    @asset_gain_entry = AssetGainEntry.new(asset_gain_entry_params)

    respond_to do |format|
      if @asset_gain_entry.save
        format.html { redirect_to @asset_gain_entry, notice: 'Asset gain entry was successfully created.' }
        format.json { render :show, status: :created, location: @asset_gain_entry }
      else
        format.html { render :new }
        format.json { render json: @asset_gain_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_gain_entries/1
  # PATCH/PUT /asset_gain_entries/1.json
  def update
    respond_to do |format|
      if @asset_gain_entry.update(asset_gain_entry_params)
        format.html { redirect_to @asset_gain_entry, notice: 'Asset gain entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_gain_entry }
      else
        format.html { render :edit }
        format.json { render json: @asset_gain_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_gain_entries/1
  # DELETE /asset_gain_entries/1.json
  def destroy
    @asset_gain_entry.destroy
    respond_to do |format|
      format.html { redirect_to asset_gain_entries_url, notice: 'Asset gain entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_gain_entry
      @asset_gain_entry = AssetGainEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_gain_entry_params
      params.require(:asset_gain_entry).permit(:Code, :name, :Asset_type, :Unit, :BookQty, :CountQty, :GainQty, :Book_seat, :Book_dept, :Book_User, :Actual_seat, :Actual_dept, :Actual_User, :fseq, :Asset_Gain_id, :FSrcFbillno, :FSrcFseq)
    end
end
