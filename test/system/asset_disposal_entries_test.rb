require "application_system_test_case"

class AssetDisposalEntriesTest < ApplicationSystemTestCase
  setup do
    @asset_disposal_entry = asset_disposal_entries(:one)
  end

  test "visiting the index" do
    visit asset_disposal_entries_url
    assert_selector "h1", text: "Asset Disposal Entries"
  end

  test "creating a Asset disposal entry" do
    visit asset_disposal_entries_url
    click_on "New Asset Disposal Entry"

    fill_in "Amount", with: @asset_disposal_entry.Amount
    fill_in "Asset seat", with: @asset_disposal_entry.Asset_seat
    fill_in "Code", with: @asset_disposal_entry.Code
    fill_in "Disposeamount", with: @asset_disposal_entry.DisposeAmount
    fill_in "Disposeprice", with: @asset_disposal_entry.DisposePrice
    fill_in "Unit", with: @asset_disposal_entry.Unit
    fill_in "Name", with: @asset_disposal_entry.name
    click_on "Create Asset disposal entry"

    assert_text "Asset disposal entry was successfully created"
    click_on "Back"
  end

  test "updating a Asset disposal entry" do
    visit asset_disposal_entries_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @asset_disposal_entry.Amount
    fill_in "Asset seat", with: @asset_disposal_entry.Asset_seat
    fill_in "Code", with: @asset_disposal_entry.Code
    fill_in "Disposeamount", with: @asset_disposal_entry.DisposeAmount
    fill_in "Disposeprice", with: @asset_disposal_entry.DisposePrice
    fill_in "Unit", with: @asset_disposal_entry.Unit
    fill_in "Name", with: @asset_disposal_entry.name
    click_on "Update Asset disposal entry"

    assert_text "Asset disposal entry was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset disposal entry" do
    visit asset_disposal_entries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset disposal entry was successfully destroyed"
  end
end
