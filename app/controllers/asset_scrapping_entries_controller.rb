class AssetScrappingEntriesController < ApplicationController
  before_action :set_asset_scrapping_entry, only: [:show, :edit, :update, :destroy]

  # GET /asset_scrapping_entries
  # GET /asset_scrapping_entries.json
  def index
    @asset_scrapping_entries = AssetScrappingEntry.all
  end

  # GET /asset_scrapping_entries/1
  # GET /asset_scrapping_entries/1.json
  def show
  end

  # GET /asset_scrapping_entries/new
  def new
    @asset_scrapping_entry = AssetScrappingEntry.new
  end

  # GET /asset_scrapping_entries/1/edit
  def edit
  end

  # POST /asset_scrapping_entries
  # POST /asset_scrapping_entries.json
  def create
    @asset_scrapping_entry = AssetScrappingEntry.new(asset_scrapping_entry_params)

    respond_to do |format|
      if @asset_scrapping_entry.save
        format.html { redirect_to @asset_scrapping_entry, notice: 'Asset scrapping entry was successfully created.' }
        format.json { render :show, status: :created, location: @asset_scrapping_entry }
      else
        format.html { render :new }
        format.json { render json: @asset_scrapping_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_scrapping_entries/1
  # PATCH/PUT /asset_scrapping_entries/1.json
  def update
    respond_to do |format|
      if @asset_scrapping_entry.update(asset_scrapping_entry_params)
        format.html { redirect_to @asset_scrapping_entry, notice: 'Asset scrapping entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_scrapping_entry }
      else
        format.html { render :edit }
        format.json { render json: @asset_scrapping_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_scrapping_entries/1
  # DELETE /asset_scrapping_entries/1.json
  def destroy
    @asset_scrapping_entry.destroy
    respond_to do |format|
      format.html { redirect_to asset_scrapping_entries_url, notice: 'Asset scrapping entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_scrapping_entry
      @asset_scrapping_entry = AssetScrappingEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_scrapping_entry_params
      params.require(:asset_scrapping_entry).permit(:Code, :Name, :Unit, :Amount, :Scrapping_Amount, :Asset_seat, :Asset_Scrapping_id)
    end
end
