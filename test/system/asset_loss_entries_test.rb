require "application_system_test_case"

class AssetLossEntriesTest < ApplicationSystemTestCase
  setup do
    @asset_loss_entry = asset_loss_entries(:one)
  end

  test "visiting the index" do
    visit asset_loss_entries_url
    assert_selector "h1", text: "Asset Loss Entries"
  end

  test "creating a Asset loss entry" do
    visit asset_loss_entries_url
    click_on "New Asset Loss Entry"

    fill_in "Actual user", with: @asset_loss_entry.Actual_User
    fill_in "Actual dept", with: @asset_loss_entry.Actual_dept
    fill_in "Actual seat", with: @asset_loss_entry.Actual_seat
    fill_in "Asset loss", with: @asset_loss_entry.Asset_Loss_id
    fill_in "Asset type", with: @asset_loss_entry.Asset_type
    fill_in "Bookqty", with: @asset_loss_entry.BookQty
    fill_in "Book user", with: @asset_loss_entry.Book_User
    fill_in "Book dept", with: @asset_loss_entry.Book_dept
    fill_in "Book seat", with: @asset_loss_entry.Book_seat
    fill_in "Code", with: @asset_loss_entry.Code
    fill_in "Countqty", with: @asset_loss_entry.CountQty
    fill_in "Fsrcfbillno", with: @asset_loss_entry.FSrcFbillno
    fill_in "Fsrcfseq", with: @asset_loss_entry.FSrcFseq
    fill_in "Lossqty", with: @asset_loss_entry.LossQty
    fill_in "Unit", with: @asset_loss_entry.Unit
    fill_in "Fseq", with: @asset_loss_entry.fseq
    fill_in "Name", with: @asset_loss_entry.name
    click_on "Create Asset loss entry"

    assert_text "Asset loss entry was successfully created"
    click_on "Back"
  end

  test "updating a Asset loss entry" do
    visit asset_loss_entries_url
    click_on "Edit", match: :first

    fill_in "Actual user", with: @asset_loss_entry.Actual_User
    fill_in "Actual dept", with: @asset_loss_entry.Actual_dept
    fill_in "Actual seat", with: @asset_loss_entry.Actual_seat
    fill_in "Asset loss", with: @asset_loss_entry.Asset_Loss_id
    fill_in "Asset type", with: @asset_loss_entry.Asset_type
    fill_in "Bookqty", with: @asset_loss_entry.BookQty
    fill_in "Book user", with: @asset_loss_entry.Book_User
    fill_in "Book dept", with: @asset_loss_entry.Book_dept
    fill_in "Book seat", with: @asset_loss_entry.Book_seat
    fill_in "Code", with: @asset_loss_entry.Code
    fill_in "Countqty", with: @asset_loss_entry.CountQty
    fill_in "Fsrcfbillno", with: @asset_loss_entry.FSrcFbillno
    fill_in "Fsrcfseq", with: @asset_loss_entry.FSrcFseq
    fill_in "Lossqty", with: @asset_loss_entry.LossQty
    fill_in "Unit", with: @asset_loss_entry.Unit
    fill_in "Fseq", with: @asset_loss_entry.fseq
    fill_in "Name", with: @asset_loss_entry.name
    click_on "Update Asset loss entry"

    assert_text "Asset loss entry was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset loss entry" do
    visit asset_loss_entries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset loss entry was successfully destroyed"
  end
end
