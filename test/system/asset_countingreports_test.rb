require "application_system_test_case"

class AssetCountingreportsTest < ApplicationSystemTestCase
  setup do
    @asset_countingreport = asset_countingreports(:one)
  end

  test "visiting the index" do
    visit asset_countingreports_url
    assert_selector "h1", text: "Asset Countingreports"
  end

  test "creating a Asset countingreport" do
    visit asset_countingreports_url
    click_on "New Asset Countingreport"

    fill_in "Approvedate", with: @asset_countingreport.APPROVEDATE
    fill_in "Approver", with: @asset_countingreport.Approver
    fill_in "Billno", with: @asset_countingreport.BillNo
    fill_in "Createdate", with: @asset_countingreport.CREATEDATE
    fill_in "Creator", with: @asset_countingreport.Creator
    fill_in "Description", with: @asset_countingreport.description
    fill_in "Fbillstatus", with: @asset_countingreport.fbillstatus
    fill_in "Fdate", with: @asset_countingreport.fdate
    click_on "Create Asset countingreport"

    assert_text "Asset countingreport was successfully created"
    click_on "Back"
  end

  test "updating a Asset countingreport" do
    visit asset_countingreports_url
    click_on "Edit", match: :first

    fill_in "Approvedate", with: @asset_countingreport.APPROVEDATE
    fill_in "Approver", with: @asset_countingreport.Approver
    fill_in "Billno", with: @asset_countingreport.BillNo
    fill_in "Createdate", with: @asset_countingreport.CREATEDATE
    fill_in "Creator", with: @asset_countingreport.Creator
    fill_in "Description", with: @asset_countingreport.description
    fill_in "Fbillstatus", with: @asset_countingreport.fbillstatus
    fill_in "Fdate", with: @asset_countingreport.fdate
    click_on "Update Asset countingreport"

    assert_text "Asset countingreport was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset countingreport" do
    visit asset_countingreports_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset countingreport was successfully destroyed"
  end
end
