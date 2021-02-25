class AssetTurnoverDetailEntriesController < ApplicationController
  before_action :set_asset_turnover_detail_entry, only: [:show, :edit, :update, :destroy]

  # GET /asset_turnover_detail_entries
  # GET /asset_turnover_detail_entries.json
  def index
    @asset_turnover_detail_entries = AssetTurnoverDetailEntry.all
  end

  # GET /asset_turnover_detail_entries/1
  # GET /asset_turnover_detail_entries/1.json
  def show
  end

  # GET /asset_turnover_detail_entries/new
  def new
    @asset_turnover_detail_entry = AssetTurnoverDetailEntry.new
  end

  # GET /asset_turnover_detail_entries/1/edit
  def edit
  end

  # POST /asset_turnover_detail_entries
  # POST /asset_turnover_detail_entries.json
  def create
    @asset_turnover_detail_entry = AssetTurnoverDetailEntry.new(asset_turnover_detail_entry_params)

    respond_to do |format|
      if @asset_turnover_detail_entry.save
        format.html { redirect_to @asset_turnover_detail_entry, notice: 'Asset turnover detail entry was successfully created.' }
        format.json { render :show, status: :created, location: @asset_turnover_detail_entry }
      else
        format.html { render :new }
        format.json { render json: @asset_turnover_detail_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_turnover_detail_entries/1
  # PATCH/PUT /asset_turnover_detail_entries/1.json
  def update
    respond_to do |format|
      if @asset_turnover_detail_entry.update(asset_turnover_detail_entry_params)
        format.html { redirect_to @asset_turnover_detail_entry, notice: 'Asset turnover detail entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_turnover_detail_entry }
      else
        format.html { render :edit }
        format.json { render json: @asset_turnover_detail_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_turnover_detail_entries/1
  # DELETE /asset_turnover_detail_entries/1.json
  def destroy
    @asset_turnover_detail_entry.destroy
    respond_to do |format|
      format.html { redirect_to asset_turnover_detail_entries_url, notice: 'Asset turnover detail entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_turnover_detail_entry
      @asset_turnover_detail_entry = AssetTurnoverDetailEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_turnover_detail_entry_params
      params.require(:asset_turnover_detail_entry).permit(:assetcards_Code, :assetcards_name, :Unit, :Amount, :Reasons_for_borrowing, :Deptment, :Employeeld, :Asset_seat, :Last_seat, :AssetTurnoverDetail_id,:FSrcFbillno,:FSrcFseq)
    end
end
