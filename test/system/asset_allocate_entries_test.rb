require "application_system_test_case"

class AssetAllocateEntriesTest < ApplicationSystemTestCase
  setup do
    @asset_allocate_entry = asset_allocate_entries(:one)
  end

  test "visiting the index" do
    visit asset_allocate_entries_url
    assert_selector "h1", text: "Asset Allocate Entries"
  end

  test "creating a Asset allocate entry" do
    visit asset_allocate_entries_url
    click_on "New Asset Allocate Entry"

    fill_in "Amount", with: @asset_allocate_entry.Amount
    fill_in "Asset allocate", with: @asset_allocate_entry.Asset_allocate_id
    fill_in "Asset seat", with: @asset_allocate_entry.Asset_seat
    fill_in "Code", with: @asset_allocate_entry.Code
    fill_in "Transfer out quantity", with: @asset_allocate_entry.Transfer_out_quantity
    fill_in "Unit", with: @asset_allocate_entry.Unit
    fill_in "Name", with: @asset_allocate_entry.name
    click_on "Create Asset allocate entry"

    assert_text "Asset allocate entry was successfully created"
    click_on "Back"
  end

  test "updating a Asset allocate entry" do
    visit asset_allocate_entries_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @asset_allocate_entry.Amount
    fill_in "Asset allocate", with: @asset_allocate_entry.Asset_allocate_id
    fill_in "Asset seat", with: @asset_allocate_entry.Asset_seat
    fill_in "Code", with: @asset_allocate_entry.Code
    fill_in "Transfer out quantity", with: @asset_allocate_entry.Transfer_out_quantity
    fill_in "Unit", with: @asset_allocate_entry.Unit
    fill_in "Name", with: @asset_allocate_entry.name
    click_on "Update Asset allocate entry"

    assert_text "Asset allocate entry was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset allocate entry" do
    visit asset_allocate_entries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset allocate entry was successfully destroyed"
  end
end
