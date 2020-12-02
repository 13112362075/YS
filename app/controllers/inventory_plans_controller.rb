class InventoryPlansController < ApplicationController
  before_action :set_inventory_plan, only: [:show, :edit, :update, :destroy]

  # GET /inventory_plans
  # GET /inventory_plans.json
  def index
    @inventory_plans = InventoryPlan.all
  end

  # GET /inventory_plans/1
  # GET /inventory_plans/1.json
  def show
  end

  # GET /inventory_plans/new
  def new
    @inventory_plan = InventoryPlan.new
  end

  # GET /inventory_plans/1/edit
  def edit
  end

  # POST /inventory_plans
  # POST /inventory_plans.json
  def create
    @inventory_plan = InventoryPlan.new(inventory_plan_params)

    respond_to do |format|
      if @inventory_plan.save
        format.html { redirect_to @inventory_plan, notice: 'Inventory plan was successfully created.' }
        format.json { render :show, status: :created, location: @inventory_plan }
      else
        format.html { render :new }
        format.json { render json: @inventory_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventory_plans/1
  # PATCH/PUT /inventory_plans/1.json
  def update
    respond_to do |format|
      if @inventory_plan.update(inventory_plan_params)
        format.html { redirect_to @inventory_plan, notice: 'Inventory plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @inventory_plan }
      else
        format.html { render :edit }
        format.json { render json: @inventory_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_plans/1
  # DELETE /inventory_plans/1.json
  def destroy
    @inventory_plan.destroy
    respond_to do |format|
      format.html { redirect_to inventory_plans_url, notice: 'Inventory plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory_plan
      @inventory_plan = InventoryPlan.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def inventory_plan_params
      params.require(:inventory_plan).permit(:Document_number, :Name, :To_id, :description)
    end
end
