class AssetaltersController < ApplicationController
  before_action :set_assetalter, only: [:show, :edit, :update, :destroy]

  # GET /assetalters
  # GET /assetalters.json
  def index
    @assetalters = Assetalter.all
  end

  # GET /assetalters/1
  # GET /assetalters/1.json
  def show
  end

  # GET /assetalters/new
  def new
    @assetalter = Assetalter.new
  end

  # GET /assetalters/1/edit
  def edit
  end

  # POST /assetalters
  # POST /assetalters.json
  def create
    @assetalter = Assetalter.new(assetalter_params)

    respond_to do |format|
      if @assetalter.save
        format.html { redirect_to @assetalter, notice: 'Assetalter was successfully created.' }
        format.json { render :show, status: :created, location: @assetalter }
      else
        format.html { render :new }
        format.json { render json: @assetalter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assetalters/1
  # PATCH/PUT /assetalters/1.json
  def update
    respond_to do |format|
      if @assetalter.update(assetalter_params)
        format.html { redirect_to @assetalter, notice: 'Assetalter was successfully updated.' }
        format.json { render :show, status: :ok, location: @assetalter }
      else
        format.html { render :edit }
        format.json { render json: @assetalter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assetalters/1
  # DELETE /assetalters/1.json
  def destroy
    @assetalter.destroy
    respond_to do |format|
      format.html { redirect_to assetalters_url, notice: 'Assetalter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assetalter
      @assetalter = Assetalter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assetalter_params
      params.require(:assetalter).permit(:Fbillno, :Code, :name, :Alterdate, :Reason)
    end
end
