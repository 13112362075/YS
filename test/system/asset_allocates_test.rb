require "application_system_test_case"

class AssetAllocatesTest < ApplicationSystemTestCase
  setup do
    @asset_allocate = asset_allocates(:one)
  end

  test "visiting the index" do
    visit asset_allocates_url
    assert_selector "h1", text: "Asset Allocates"
  end

  test "creating a Asset allocate" do
    visit asset_allocates_url
    click_on "New Asset Allocate"

    fill_in "Approvedate", with: @asset_allocate.APPROVEDATE
    fill_in "Allocate reason", with: @asset_allocate.Allocate_reason
    fill_in "Approver", with: @asset_allocate.Approver
    fill_in "Createdate", with: @asset_allocate.CREATEDATE
    fill_in "Creator", with: @asset_allocate.Creator
    fill_in "Expdate", with: @asset_allocate.Expdate
    fill_in "Fbillno", with: @asset_allocate.FBillno
    fill_in "Fbillstatus", with: @asset_allocate.FBillstatus
    click_on "Create Asset allocate"

    assert_text "Asset allocate was successfully created"
    click_on "Back"
  end

  test "updating a Asset allocate" do
    visit asset_allocates_url
    click_on "Edit", match: :first

    fill_in "Approvedate", with: @asset_allocate.APPROVEDATE
    fill_in "Allocate reason", with: @asset_allocate.Allocate_reason
    fill_in "Approver", with: @asset_allocate.Approver
    fill_in "Createdate", with: @asset_allocate.CREATEDATE
    fill_in "Creator", with: @asset_allocate.Creator
    fill_in "Expdate", with: @asset_allocate.Expdate
    fill_in "Fbillno", with: @asset_allocate.FBillno
    fill_in "Fbillstatus", with: @asset_allocate.FBillstatus
    click_on "Update Asset allocate"

    assert_text "Asset allocate was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset allocate" do
    visit asset_allocates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset allocate was successfully destroyed"
  end
end
