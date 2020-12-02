require 'test_helper'

class InventoryPlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inventory_plan = inventory_plans(:one)
  end

  test "should get index" do
    get inventory_plans_url
    assert_response :success
  end

  test "should get new" do
    get new_inventory_plan_url
    assert_response :success
  end

  test "should create inventory_plan" do
    assert_difference('InventoryPlan.count') do
      post inventory_plans_url, params: { inventory_plan: { Document_number: @inventory_plan.Document_number, Name: @inventory_plan.Name, To_id: @inventory_plan.To_id, description: @inventory_plan.description } }
    end

    assert_redirected_to inventory_plan_url(InventoryPlan.last)
  end

  test "should show inventory_plan" do
    get inventory_plan_url(@inventory_plan)
    assert_response :success
  end

  test "should get edit" do
    get edit_inventory_plan_url(@inventory_plan)
    assert_response :success
  end

  test "should update inventory_plan" do
    patch inventory_plan_url(@inventory_plan), params: { inventory_plan: { Document_number: @inventory_plan.Document_number, Name: @inventory_plan.Name, To_id: @inventory_plan.To_id, description: @inventory_plan.description } }
    assert_redirected_to inventory_plan_url(@inventory_plan)
  end

  test "should destroy inventory_plan" do
    assert_difference('InventoryPlan.count', -1) do
      delete inventory_plan_url(@inventory_plan)
    end

    assert_redirected_to inventory_plans_url
  end
end
