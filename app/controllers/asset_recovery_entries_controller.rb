class AssetRecoveryEntriesController < ApplicationController
  before_action :set_asset_recovery_entry, only: [:show, :edit, :update, :destroy]

  # GET /asset_recovery_entries
  # GET /asset_recovery_entries.json
  def index
    @asset_recovery_entries = AssetRecoveryEntry.all
  end

  # GET /asset_recovery_entries/1
  # GET /asset_recovery_entries/1.json
  def show
  end

  # GET /asset_recovery_entries/new
  def new
    @asset_recovery_entry = AssetRecoveryEntry.new
  end

  # GET /asset_recovery_entries/1/edit
  def edit
  end

  # POST /asset_recovery_entries
  # POST /asset_recovery_entries.json
  def create
    @asset_recovery_entry = AssetRecoveryEntry.new(asset_recovery_entry_params)

    respond_to do |format|
      if @asset_recovery_entry.save
        format.html { redirect_to @asset_recovery_entry, notice: 'Asset recovery entry was successfully created.' }
        format.json { render :show, status: :created, location: @asset_recovery_entry }
      else
        format.html { render :new }
        format.json { render json: @asset_recovery_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_recovery_entries/1
  # PATCH/PUT /asset_recovery_entries/1.json
  def update
    respond_to do |format|
      if @asset_recovery_entry.update(asset_recovery_entry_params)
        format.html { redirect_to @asset_recovery_entry, notice: 'Asset recovery entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_recovery_entry }
      else
        format.html { render :edit }
        format.json { render json: @asset_recovery_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_recovery_entries/1
  # DELETE /asset_recovery_entries/1.json
  def destroy
    @asset_recovery_entry.destroy
    respond_to do |format|
      format.html { redirect_to asset_recovery_entries_url, notice: 'Asset recovery entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_recovery_entry
      @asset_recovery_entry = AssetRecoveryEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_recovery_entry_params
      params.require(:asset_recovery_entry).permit(:Code, :name, :Asset_type, :Unit, :Requisition_Amount, :Amount_returned, :Amount_Returnable, :Asset_status, :Requisition_Department, :Requisition_Employeeld, :Requisition_use, :Asset_recovery_id)
    end
end
