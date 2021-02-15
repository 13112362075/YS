require "application_system_test_case"

class AssetCountingreportEntriesTest < ApplicationSystemTestCase
  setup do
    @asset_countingreport_entry = asset_countingreport_entries(:one)
  end

  test "visiting the index" do
    visit asset_countingreport_entries_url
    assert_selector "h1", text: "Asset Countingreport Entries"
  end

  test "creating a Asset countingreport entry" do
    visit asset_countingreport_entries_url
    click_on "New Asset Countingreport Entry"

    fill_in "Asset countingreport", with: @asset_countingreport_entry.Asset_Countingreport_id
    fill_in "Asset status", with: @asset_countingreport_entry.Asset_status
    fill_in "Asset type", with: @asset_countingreport_entry.Asset_type
    fill_in "Bookqty", with: @asset_countingreport_entry.BookQty
    fill_in "Book user", with: @asset_countingreport_entry.Book_User
    fill_in "Book dept", with: @asset_countingreport_entry.Book_dept
    fill_in "Book seat", with: @asset_countingreport_entry.Book_seat
    fill_in "Code", with: @asset_countingreport_entry.Code
    fill_in "Countdate", with: @asset_countingreport_entry.CountDate
    fill_in "Countqty", with: @asset_countingreport_entry.CountQty
    fill_in "Headnote", with: @asset_countingreport_entry.Headnote
    fill_in "Inventuser", with: @asset_countingreport_entry.InventUser
    fill_in "Invent dept", with: @asset_countingreport_entry.Invent_dept
    fill_in "Invent seat", with: @asset_countingreport_entry.Invent_seat
    fill_in "Model", with: @asset_countingreport_entry.Model
    fill_in "Unit", with: @asset_countingreport_entry.Unit
    fill_in "Variance", with: @asset_countingreport_entry.Variance
    fill_in "Fseq", with: @asset_countingreport_entry.fseq
    fill_in "Name", with: @asset_countingreport_entry.name
    click_on "Create Asset countingreport entry"

    assert_text "Asset countingreport entry was successfully created"
    click_on "Back"
  end

  test "updating a Asset countingreport entry" do
    visit asset_countingreport_entries_url
    click_on "Edit", match: :first

    fill_in "Asset countingreport", with: @asset_countingreport_entry.Asset_Countingreport_id
    fill_in "Asset status", with: @asset_countingreport_entry.Asset_status
    fill_in "Asset type", with: @asset_countingreport_entry.Asset_type
    fill_in "Bookqty", with: @asset_countingreport_entry.BookQty
    fill_in "Book user", with: @asset_countingreport_entry.Book_User
    fill_in "Book dept", with: @asset_countingreport_entry.Book_dept
    fill_in "Book seat", with: @asset_countingreport_entry.Book_seat
    fill_in "Code", with: @asset_countingreport_entry.Code
    fill_in "Countdate", with: @asset_countingreport_entry.CountDate
    fill_in "Countqty", with: @asset_countingreport_entry.CountQty
    fill_in "Headnote", with: @asset_countingreport_entry.Headnote
    fill_in "Inventuser", with: @asset_countingreport_entry.InventUser
    fill_in "Invent dept", with: @asset_countingreport_entry.Invent_dept
    fill_in "Invent seat", with: @asset_countingreport_entry.Invent_seat
    fill_in "Model", with: @asset_countingreport_entry.Model
    fill_in "Unit", with: @asset_countingreport_entry.Unit
    fill_in "Variance", with: @asset_countingreport_entry.Variance
    fill_in "Fseq", with: @asset_countingreport_entry.fseq
    fill_in "Name", with: @asset_countingreport_entry.name
    click_on "Update Asset countingreport entry"

    assert_text "Asset countingreport entry was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset countingreport entry" do
    visit asset_countingreport_entries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset countingreport entry was successfully destroyed"
  end
end
