class AssetDisposalEntriesController < ApplicationController
  before_action :set_asset_disposal_entry, only: [:show, :edit, :update, :destroy]

  # GET /asset_disposal_entries
  # GET /asset_disposal_entries.json
  def index
    @asset_disposal_entries = AssetDisposalEntry.all
  end

  # GET /asset_disposal_entries/1
  # GET /asset_disposal_entries/1.json
  def show
  end

  # GET /asset_disposal_entries/new
  def new
    @asset_disposal_entry = AssetDisposalEntry.new
  end

  # GET /asset_disposal_entries/1/edit
  def edit
  end

  # POST /asset_disposal_entries
  # POST /asset_disposal_entries.json
  def create
    @asset_disposal_entry = AssetDisposalEntry.new(asset_disposal_entry_params)

    respond_to do |format|
      if @asset_disposal_entry.save
        format.html { redirect_to @asset_disposal_entry, notice: 'Asset disposal entry was successfully created.' }
        format.json { render :show, status: :created, location: @asset_disposal_entry }
      else
        format.html { render :new }
        format.json { render json: @asset_disposal_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_disposal_entries/1
  # PATCH/PUT /asset_disposal_entries/1.json
  def update
    respond_to do |format|
      if @asset_disposal_entry.update(asset_disposal_entry_params)
        format.html { redirect_to @asset_disposal_entry, notice: 'Asset disposal entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_disposal_entry }
      else
        format.html { render :edit }
        format.json { render json: @asset_disposal_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_disposal_entries/1
  # DELETE /asset_disposal_entries/1.json
  def destroy
    @asset_disposal_entry.destroy
    respond_to do |format|
      format.html { redirect_to asset_disposal_entries_url, notice: 'Asset disposal entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_disposal_entry
      @asset_disposal_entry = AssetDisposalEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_disposal_entry_params
      params.require(:asset_disposal_entry).permit(:Code, :name, :Unit, :Amount, :DisposeAmount, :Asset_seat, :DisposePrice,:AssetDisposal_id,:fseq,:Addtype_id)
    end
end
