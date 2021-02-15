require "application_system_test_case"

class AssetGainEntriesTest < ApplicationSystemTestCase
  setup do
    @asset_gain_entry = asset_gain_entries(:one)
  end

  test "visiting the index" do
    visit asset_gain_entries_url
    assert_selector "h1", text: "Asset Gain Entries"
  end

  test "creating a Asset gain entry" do
    visit asset_gain_entries_url
    click_on "New Asset Gain Entry"

    fill_in "Actual user", with: @asset_gain_entry.Actual_User
    fill_in "Actual dept", with: @asset_gain_entry.Actual_dept
    fill_in "Actual seat", with: @asset_gain_entry.Actual_seat
    fill_in "Asset gain", with: @asset_gain_entry.Asset_Gain_id
    fill_in "Asset type", with: @asset_gain_entry.Asset_type
    fill_in "Bookqty", with: @asset_gain_entry.BookQty
    fill_in "Book user", with: @asset_gain_entry.Book_User
    fill_in "Book dept", with: @asset_gain_entry.Book_dept
    fill_in "Book seat", with: @asset_gain_entry.Book_seat
    fill_in "Code", with: @asset_gain_entry.Code
    fill_in "Countqty", with: @asset_gain_entry.CountQty
    fill_in "Fsrcfbillno", with: @asset_gain_entry.FSrcFbillno
    fill_in "Fsrcfseq", with: @asset_gain_entry.FSrcFseq
    fill_in "Gainqty", with: @asset_gain_entry.GainQty
    fill_in "Unit", with: @asset_gain_entry.Unit
    fill_in "Fseq", with: @asset_gain_entry.fseq
    fill_in "Name", with: @asset_gain_entry.name
    click_on "Create Asset gain entry"

    assert_text "Asset gain entry was successfully created"
    click_on "Back"
  end

  test "updating a Asset gain entry" do
    visit asset_gain_entries_url
    click_on "Edit", match: :first

    fill_in "Actual user", with: @asset_gain_entry.Actual_User
    fill_in "Actual dept", with: @asset_gain_entry.Actual_dept
    fill_in "Actual seat", with: @asset_gain_entry.Actual_seat
    fill_in "Asset gain", with: @asset_gain_entry.Asset_Gain_id
    fill_in "Asset type", with: @asset_gain_entry.Asset_type
    fill_in "Bookqty", with: @asset_gain_entry.BookQty
    fill_in "Book user", with: @asset_gain_entry.Book_User
    fill_in "Book dept", with: @asset_gain_entry.Book_dept
    fill_in "Book seat", with: @asset_gain_entry.Book_seat
    fill_in "Code", with: @asset_gain_entry.Code
    fill_in "Countqty", with: @asset_gain_entry.CountQty
    fill_in "Fsrcfbillno", with: @asset_gain_entry.FSrcFbillno
    fill_in "Fsrcfseq", with: @asset_gain_entry.FSrcFseq
    fill_in "Gainqty", with: @asset_gain_entry.GainQty
    fill_in "Unit", with: @asset_gain_entry.Unit
    fill_in "Fseq", with: @asset_gain_entry.fseq
    fill_in "Name", with: @asset_gain_entry.name
    click_on "Update Asset gain entry"

    assert_text "Asset gain entry was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset gain entry" do
    visit asset_gain_entries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset gain entry was successfully destroyed"
  end
end
