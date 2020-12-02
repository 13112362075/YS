require "application_system_test_case"

class InventoryPlansTest < ApplicationSystemTestCase
  setup do
    @inventory_plan = inventory_plans(:one)
  end

  test "visiting the index" do
    visit inventory_plans_url
    assert_selector "h1", text: "Inventory Plans"
  end

  test "creating a Inventory plan" do
    visit inventory_plans_url
    click_on "New Inventory Plan"

    fill_in "Document number", with: @inventory_plan.Document_number
    fill_in "Name", with: @inventory_plan.Name
    fill_in "To", with: @inventory_plan.To_id
    fill_in "Description", with: @inventory_plan.description
    click_on "Create Inventory plan"

    assert_text "Inventory plan was successfully created"
    click_on "Back"
  end

  test "updating a Inventory plan" do
    visit inventory_plans_url
    click_on "Edit", match: :first

    fill_in "Document number", with: @inventory_plan.Document_number
    fill_in "Name", with: @inventory_plan.Name
    fill_in "To", with: @inventory_plan.To_id
    fill_in "Description", with: @inventory_plan.description
    click_on "Update Inventory plan"

    assert_text "Inventory plan was successfully updated"
    click_on "Back"
  end

  test "destroying a Inventory plan" do
    visit inventory_plans_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Inventory plan was successfully destroyed"
  end
end
