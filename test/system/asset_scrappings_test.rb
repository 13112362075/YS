require "application_system_test_case"

class AssetScrappingsTest < ApplicationSystemTestCase
  setup do
    @asset_scrapping = asset_scrappings(:one)
  end

  test "visiting the index" do
    visit asset_scrappings_url
    assert_selector "h1", text: "Asset Scrappings"
  end

  test "creating a Asset scrapping" do
    visit asset_scrappings_url
    click_on "New Asset Scrapping"

    fill_in "Addtype", with: @asset_scrapping.Addtype
    fill_in "Addtype reason", with: @asset_scrapping.Addtype_Reason
    fill_in "Date", with: @asset_scrapping.Date
    fill_in "Document number", with: @asset_scrapping.Document_number
    click_on "Create Asset scrapping"

    assert_text "Asset scrapping was successfully created"
    click_on "Back"
  end

  test "updating a Asset scrapping" do
    visit asset_scrappings_url
    click_on "Edit", match: :first

    fill_in "Addtype", with: @asset_scrapping.Addtype
    fill_in "Addtype reason", with: @asset_scrapping.Addtype_Reason
    fill_in "Date", with: @asset_scrapping.Date
    fill_in "Document number", with: @asset_scrapping.Document_number
    click_on "Update Asset scrapping"

    assert_text "Asset scrapping was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset scrapping" do
    visit asset_scrappings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset scrapping was successfully destroyed"
  end
end
