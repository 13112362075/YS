require "application_system_test_case"

class AssetScrappingEntriesTest < ApplicationSystemTestCase
  setup do
    @asset_scrapping_entry = asset_scrapping_entries(:one)
  end

  test "visiting the index" do
    visit asset_scrapping_entries_url
    assert_selector "h1", text: "Asset Scrapping Entries"
  end

  test "creating a Asset scrapping entry" do
    visit asset_scrapping_entries_url
    click_on "New Asset Scrapping Entry"

    fill_in "Amount", with: @asset_scrapping_entry.Amount
    fill_in "Asset scrapping", with: @asset_scrapping_entry.Asset_Scrapping_id
    fill_in "Asset seat", with: @asset_scrapping_entry.Asset_seat
    fill_in "Code", with: @asset_scrapping_entry.Code
    fill_in "Name", with: @asset_scrapping_entry.Name
    fill_in "Scrapping amount", with: @asset_scrapping_entry.Scrapping_Amount
    fill_in "Unit", with: @asset_scrapping_entry.Unit
    click_on "Create Asset scrapping entry"

    assert_text "Asset scrapping entry was successfully created"
    click_on "Back"
  end

  test "updating a Asset scrapping entry" do
    visit asset_scrapping_entries_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @asset_scrapping_entry.Amount
    fill_in "Asset scrapping", with: @asset_scrapping_entry.Asset_Scrapping_id
    fill_in "Asset seat", with: @asset_scrapping_entry.Asset_seat
    fill_in "Code", with: @asset_scrapping_entry.Code
    fill_in "Name", with: @asset_scrapping_entry.Name
    fill_in "Scrapping amount", with: @asset_scrapping_entry.Scrapping_Amount
    fill_in "Unit", with: @asset_scrapping_entry.Unit
    click_on "Update Asset scrapping entry"

    assert_text "Asset scrapping entry was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset scrapping entry" do
    visit asset_scrapping_entries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset scrapping entry was successfully destroyed"
  end
end
