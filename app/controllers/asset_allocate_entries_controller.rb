class AssetAllocateEntriesController < ApplicationController
  before_action :set_asset_allocate_entry, only: [:show, :edit, :update, :destroy]

  # GET /asset_allocate_entries
  # GET /asset_allocate_entries.json
  def index
    @asset_allocate_entries = AssetAllocateEntry.all
  end

  # GET /asset_allocate_entries/1
  # GET /asset_allocate_entries/1.json
  def show
  end

  # GET /asset_allocate_entries/new
  def new
    @asset_allocate_entry = AssetAllocateEntry.new
  end

  # GET /asset_allocate_entries/1/edit
  def edit
  end

  # POST /asset_allocate_entries
  # POST /asset_allocate_entries.json
  def create
    @asset_allocate_entry = AssetAllocateEntry.new(asset_allocate_entry_params)

    respond_to do |format|
      if @asset_allocate_entry.save
        format.html { redirect_to @asset_allocate_entry, notice: 'Asset allocate entry was successfully created.' }
        format.json { render :show, status: :created, location: @asset_allocate_entry }
      else
        format.html { render :new }
        format.json { render json: @asset_allocate_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_allocate_entries/1
  # PATCH/PUT /asset_allocate_entries/1.json
  def update
    respond_to do |format|
      if @asset_allocate_entry.update(asset_allocate_entry_params)
        format.html { redirect_to @asset_allocate_entry, notice: 'Asset allocate entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_allocate_entry }
      else
        format.html { render :edit }
        format.json { render json: @asset_allocate_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_allocate_entries/1
  # DELETE /asset_allocate_entries/1.json
  def destroy
    @asset_allocate_entry.destroy
    respond_to do |format|
      format.html { redirect_to asset_allocate_entries_url, notice: 'Asset allocate entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_allocate_entry
      @asset_allocate_entry = AssetAllocateEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_allocate_entry_params
      params.require(:asset_allocate_entry).permit(:Code, :name, :Unit, :Model, :Amount, :EXPdept, :Employeeld, :Asset_seat, :EXPQTY, :IMPdept, :Newuser, :IMP_seat, :fseq, :Asset_allocate_id)
    end
end
