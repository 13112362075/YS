require "application_system_test_case"

class AssetPickingEntriesTest < ApplicationSystemTestCase
  setup do
    @asset_picking_entry = asset_picking_entries(:one)
  end

  test "visiting the index" do
    visit asset_picking_entries_url
    assert_selector "h1", text: "Asset Picking Entries"
  end

  test "creating a Asset picking entry" do
    visit asset_picking_entries_url
    click_on "New Asset Picking Entry"

    fill_in "Assetpicking", with: @asset_picking_entry.AssetPicking_id
    fill_in "Asset seat", with: @asset_picking_entry.Asset_seat
    fill_in "Asset type", with: @asset_picking_entry.Asset_type
    fill_in "Backqty", with: @asset_picking_entry.BackQty
    fill_in "Canbackqty", with: @asset_picking_entry.CanbackQty
    fill_in "Code", with: @asset_picking_entry.Code
    fill_in "Fsrcfbillno", with: @asset_picking_entry.FSrcFbillno
    fill_in "Fsrcfseq", with: @asset_picking_entry.FSrcFseq
    fill_in "Pickingfor", with: @asset_picking_entry.PickingFor
    fill_in "Picking amount", with: @asset_picking_entry.Picking_Amount
    fill_in "Picking seat", with: @asset_picking_entry.Picking_seat
    fill_in "Unit", with: @asset_picking_entry.Unit
    fill_in "Name", with: @asset_picking_entry.name
    click_on "Create Asset picking entry"

    assert_text "Asset picking entry was successfully created"
    click_on "Back"
  end

  test "updating a Asset picking entry" do
    visit asset_picking_entries_url
    click_on "Edit", match: :first

    fill_in "Assetpicking", with: @asset_picking_entry.AssetPicking_id
    fill_in "Asset seat", with: @asset_picking_entry.Asset_seat
    fill_in "Asset type", with: @asset_picking_entry.Asset_type
    fill_in "Backqty", with: @asset_picking_entry.BackQty
    fill_in "Canbackqty", with: @asset_picking_entry.CanbackQty
    fill_in "Code", with: @asset_picking_entry.Code
    fill_in "Fsrcfbillno", with: @asset_picking_entry.FSrcFbillno
    fill_in "Fsrcfseq", with: @asset_picking_entry.FSrcFseq
    fill_in "Pickingfor", with: @asset_picking_entry.PickingFor
    fill_in "Picking amount", with: @asset_picking_entry.Picking_Amount
    fill_in "Picking seat", with: @asset_picking_entry.Picking_seat
    fill_in "Unit", with: @asset_picking_entry.Unit
    fill_in "Name", with: @asset_picking_entry.name
    click_on "Update Asset picking entry"

    assert_text "Asset picking entry was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset picking entry" do
    visit asset_picking_entries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset picking entry was successfully destroyed"
  end
end
