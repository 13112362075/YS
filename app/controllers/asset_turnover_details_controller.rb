class AssetTurnoverDetailsController < ApplicationController
  before_action :set_asset_turnover_detail, only: [:show, :edit, :update, :destroy]



  # GET /asset_turnover_details
  # GET /asset_turnover_details.json
  def index
    @asset_turnover_details = AssetTurnoverDetail.all
  end

  # GET /asset_turnover_details/1
  # GET /asset_turnover_details/1.json
  def show
  end

  # GET /asset_turnover_details/new
  def new
    @asset_turnover_detail = AssetTurnoverDetail.new
    @entry = AssetTurnoverDetailEntry.new
  end

  # GET /asset_turnover_details/1/edit
  def edit
  end

  # POST /asset_turnover_details
  # POST /asset_turnover_details.json
  def create
    @asset_turnover_detail = AssetTurnoverDetail.new(asset_turnover_detail_params)

    respond_to do |format|
      if @asset_turnover_detail.save
        puts @asset_turnover_detail.id
        format.html { redirect_to @asset_turnover_detail, notice: 'Asset turnover detail was successfully created.' }
        format.json { render :show, status: :created, location: @asset_turnover_detail }
      else
        format.html { render :new }
        format.json { render json: @asset_turnover_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asset_turnover_details/1
  # PATCH/PUT /asset_turnover_details/1.json
  def update
    respond_to do |format|
      if @asset_turnover_detail.update(asset_turnover_detail_params)
        format.html { redirect_to @asset_turnover_detail, notice: 'Asset turnover detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset_turnover_detail }
      else
        format.html { render :edit }
        format.json { render json: @asset_turnover_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_turnover_details/1
  # DELETE /asset_turnover_details/1.json
  def destroy
    @asset_turnover_detail.destroy
    respond_to do |format|
      format.html { redirect_to asset_turnover_details_url, notice: 'Asset turnover detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset_turnover_detail
      @asset_turnover_detail = AssetTurnoverDetail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_turnover_detail_params
      params.require(:asset_turnover_detail).permit(:Document_number, :Borrowing_date, :Borrowing_Department, :Borrowed_To_id, :Loaner)
    end
end
