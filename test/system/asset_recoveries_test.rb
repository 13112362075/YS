require "application_system_test_case"

class AssetRecoveriesTest < ApplicationSystemTestCase
  setup do
    @asset_recovery = asset_recoveries(:one)
  end

  test "visiting the index" do
    visit asset_recoveries_url
    assert_selector "h1", text: "Asset Recoveries"
  end

  test "creating a Asset recovery" do
    visit asset_recoveries_url
    click_on "New Asset Recovery"

    fill_in "Documentnumber", with: @asset_recovery.Documentnumber
    fill_in "Requisition date", with: @asset_recovery.Requisition_Date
    fill_in "Type of business", with: @asset_recovery.Type_of_business
    click_on "Create Asset recovery"

    assert_text "Asset recovery was successfully created"
    click_on "Back"
  end

  test "updating a Asset recovery" do
    visit asset_recoveries_url
    click_on "Edit", match: :first

    fill_in "Documentnumber", with: @asset_recovery.Documentnumber
    fill_in "Requisition date", with: @asset_recovery.Requisition_Date
    fill_in "Type of business", with: @asset_recovery.Type_of_business
    click_on "Update Asset recovery"

    assert_text "Asset recovery was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset recovery" do
    visit asset_recoveries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset recovery was successfully destroyed"
  end
end
