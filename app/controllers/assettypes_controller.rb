class AssettypesController < ApplicationController
  before_action :set_assettype, only: [:show, :edit, :update, :destroy]

  # GET /assettypes
  # GET /assettypes.json
  def index
    @assettypes = Assettype.all
  end

  # GET /assettypes/1
  # GET /assettypes/1.json
  def show
  end

  # GET /assettypes/new
  def new
    @assettype = Assettype.new
  end

  # GET /assettypes/1/edit
  def edit
  end

  # POST /assettypes
  # POST /assettypes.json
  def create
    @assettype = Assettype.new(assettype_params)

    respond_to do |format|
      if @assettype.save
        format.html { redirect_to @assettype, notice: 'Assettype was successfully created.' }
        format.json { render :show, status: :created, location: @assettype }
      else
        format.html { render :new }
        format.json { render json: @assettype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assettypes/1
  # PATCH/PUT /assettypes/1.json
  def update
    respond_to do |format|
      if @assettype.update(assettype_params)
        format.html { redirect_to @assettype, notice: 'Assettype was successfully updated.' }
        format.json { render :show, status: :ok, location: @assettype }
      else
        format.html { render :edit }
        format.json { render json: @assettype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assettypes/1
  # DELETE /assettypes/1.json
  def destroy
    @assettype.destroy
    respond_to do |format|
      format.html { redirect_to assettypes_url, notice: 'Assettype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assettype
      @assettype = Assettype.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assettype_params
      params.require(:assettype).permit(:Assettypecode, :Name, :Orgainize_id, :description)
    end
end
