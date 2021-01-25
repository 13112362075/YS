require "application_system_test_case"

class AssetPickingsTest < ApplicationSystemTestCase
  setup do
    @asset_picking = asset_pickings(:one)
  end

  test "visiting the index" do
    visit asset_pickings_url
    assert_selector "h1", text: "Asset Pickings"
  end

  test "creating a Asset picking" do
    visit asset_pickings_url
    click_on "New Asset Picking"

    fill_in "Approvedate", with: @asset_picking.ApproveDate
    fill_in "Approver", with: @asset_picking.Approver
    fill_in "Createdate", with: @asset_picking.CreateDate
    fill_in "Creator", with: @asset_picking.Creator
    fill_in "Fbillno", with: @asset_picking.FBillno
    fill_in "Fbillstatus", with: @asset_picking.Fbillstatus
    fill_in "Picking date", with: @asset_picking.Picking_Date
    fill_in "Picking dept", with: @asset_picking.Picking_Dept
    fill_in "Picking employeeld", with: @asset_picking.Picking_Employeeld
    fill_in "Type of business", with: @asset_picking.Type_of_business
    click_on "Create Asset picking"

    assert_text "Asset picking was successfully created"
    click_on "Back"
  end

  test "updating a Asset picking" do
    visit asset_pickings_url
    click_on "Edit", match: :first

    fill_in "Approvedate", with: @asset_picking.ApproveDate
    fill_in "Approver", with: @asset_picking.Approver
    fill_in "Createdate", with: @asset_picking.CreateDate
    fill_in "Creator", with: @asset_picking.Creator
    fill_in "Fbillno", with: @asset_picking.FBillno
    fill_in "Fbillstatus", with: @asset_picking.Fbillstatus
    fill_in "Picking date", with: @asset_picking.Picking_Date
    fill_in "Picking dept", with: @asset_picking.Picking_Dept
    fill_in "Picking employeeld", with: @asset_picking.Picking_Employeeld
    fill_in "Type of business", with: @asset_picking.Type_of_business
    click_on "Update Asset picking"

    assert_text "Asset picking was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset picking" do
    visit asset_pickings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset picking was successfully destroyed"
  end
end
