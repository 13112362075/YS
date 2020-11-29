class AssetAllocatesController < ApplicationController
  before_action :set_asset_allocate, only: [:show, :edit, :update, :destroy]

  # GET /asset_allocates
  # GET /asset_allocates.json
  def index
    @asset_allocates = AssetAllocate.all
  end

  # GET /asset_allocates/1
  # GET /asset_allocates/1.json
  def show
  end

  # GET /asset_allocates/new
  def new
    @asset_allocate = AssetAllocate.new
    @entry = AssetAllocateEntry.new
  end

  # GET /asset_allocates/1/edit
  def edit
  end

  # POST /asset_allocates
  # POST /asset_allocates.json
  def create
    @asset_allocate = AssetAllocate.new(asset_allocate_params)

    respond_to do |format|
      if @asset_allocate.save
        format.html { redirect_to @asset_allocate, notice: 'Asset allocate was successfully created.' }
        format.json { render :show, status: :created, location: @asset_allocate }
      else
        format.html { render :new }
        format.json { render json: @asset_allocate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_allocates/1
  # PATCH/PUT /asset_allocates/1.json
  def update
    respond_to do |format|
      if @asset_allocate.update(asset_allocate_params)
        format.html { redirect_to @asset_allocate, notice: 'Asset allocate was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_allocate }
      else
        format.html { render :edit }
        format.json { render json: @asset_allocate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_allocates/1
  # DELETE /asset_allocates/1.json
  def destroy
    @asset_allocate.destroy
    respond_to do |format|
      format.html { redirect_to asset_allocates_url, notice: 'Asset allocate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_allocate
      @asset_allocate = AssetAllocate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_allocate_params
      params.require(:asset_allocate).permit(:Document_number, :Pull_up_to_id, :Bring_in_to_id, :Pull_up_date, :Allocate_reason, :Bring_in_Number, :Bring_in_Confirm)
    end
end
