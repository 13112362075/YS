require "application_system_test_case"

class AssetGainsTest < ApplicationSystemTestCase
  setup do
    @asset_gain = asset_gains(:one)
  end

  test "visiting the index" do
    visit asset_gains_url
    assert_selector "h1", text: "Asset Gains"
  end

  test "creating a Asset gain" do
    visit asset_gains_url
    click_on "New Asset Gain"

    fill_in "Approvedate", with: @asset_gain.APPROVEDATE
    fill_in "Approver", with: @asset_gain.Approver
    fill_in "Billno", with: @asset_gain.BillNo
    fill_in "Createdate", with: @asset_gain.CREATEDATE
    fill_in "Creator", with: @asset_gain.Creator
    fill_in "Description", with: @asset_gain.description
    fill_in "Fbillstatus", with: @asset_gain.fbillstatus
    fill_in "Fdate", with: @asset_gain.fdate
    click_on "Create Asset gain"

    assert_text "Asset gain was successfully created"
    click_on "Back"
  end

  test "updating a Asset gain" do
    visit asset_gains_url
    click_on "Edit", match: :first

    fill_in "Approvedate", with: @asset_gain.APPROVEDATE
    fill_in "Approver", with: @asset_gain.Approver
    fill_in "Billno", with: @asset_gain.BillNo
    fill_in "Createdate", with: @asset_gain.CREATEDATE
    fill_in "Creator", with: @asset_gain.Creator
    fill_in "Description", with: @asset_gain.description
    fill_in "Fbillstatus", with: @asset_gain.fbillstatus
    fill_in "Fdate", with: @asset_gain.fdate
    click_on "Update Asset gain"

    assert_text "Asset gain was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset gain" do
    visit asset_gains_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset gain was successfully destroyed"
  end
end
