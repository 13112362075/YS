class AssetalterEntriesController < ApplicationController
  before_action :set_assetalter_entry, only: [:show, :edit, :update, :destroy]

  # GET /assetalter_entries
  # GET /assetalter_entries.json
  def index
    @assetalter_entries = AssetalterEntry.all
  end

  # GET /assetalter_entries/1
  # GET /assetalter_entries/1.json
  def show
  end

  # GET /assetalter_entries/new
  def new
    @assetalter_entry = AssetalterEntry.new
  end

  # GET /assetalter_entries/1/edit
  def edit
  end

  # POST /assetalter_entries
  # POST /assetalter_entries.json
  def create
    @assetalter_entry = AssetalterEntry.new(assetalter_entry_params)

    respond_to do |format|
      if @assetalter_entry.save
        format.html { redirect_to @assetalter_entry, notice: 'Assetalter entry was successfully created.' }
        format.json { render :show, status: :created, location: @assetalter_entry }
      else
        format.html { render :new }
        format.json { render json: @assetalter_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assetalter_entries/1
  # PATCH/PUT /assetalter_entries/1.json
  def update
    respond_to do |format|
      if @assetalter_entry.update(assetalter_entry_params)
        format.html { redirect_to @assetalter_entry, notice: 'Assetalter entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @assetalter_entry }
      else
        format.html { render :edit }
        format.json { render json: @assetalter_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assetalter_entries/1
  # DELETE /assetalter_entries/1.json
  def destroy
    @assetalter_entry.destroy
    respond_to do |format|
      format.html { redirect_to assetalter_entries_url, notice: 'Assetalter entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assetalter_entry
      @assetalter_entry = AssetalterEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assetalter_entry_params
      params.require(:assetalter_entry).permit(:Altertype, :Information_Old, :Information_New, :Assetalter_id)
    end
end
