require 'test_helper'

class AssetPickingEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset_picking_entry = asset_picking_entries(:one)
  end

  test "should get index" do
    get asset_picking_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_picking_entry_url
    assert_response :success
  end

  test "should create asset_picking_entry" do
    assert_difference('AssetPickingEntry.count') do
      post asset_picking_entries_url, params: { asset_picking_entry: { AssetPicking_id: @asset_picking_entry.AssetPicking_id, Asset_seat: @asset_picking_entry.Asset_seat, Asset_type: @asset_picking_entry.Asset_type, BackQty: @asset_picking_entry.BackQty, CanbackQty: @asset_picking_entry.CanbackQty, Code: @asset_picking_entry.Code, FSrcFbillno: @asset_picking_entry.FSrcFbillno, FSrcFseq: @asset_picking_entry.FSrcFseq, PickingFor: @asset_picking_entry.PickingFor, Picking_Amount: @asset_picking_entry.Picking_Amount, Picking_seat: @asset_picking_entry.Picking_seat, Unit: @asset_picking_entry.Unit, name: @asset_picking_entry.name } }
    end

    assert_redirected_to asset_picking_entry_url(AssetPickingEntry.last)
  end

  test "should show asset_picking_entry" do
    get asset_picking_entry_url(@asset_picking_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_picking_entry_url(@asset_picking_entry)
    assert_response :success
  end

  test "should update asset_picking_entry" do
    patch asset_picking_entry_url(@asset_picking_entry), params: { asset_picking_entry: { AssetPicking_id: @asset_picking_entry.AssetPicking_id, Asset_seat: @asset_picking_entry.Asset_seat, Asset_type: @asset_picking_entry.Asset_type, BackQty: @asset_picking_entry.BackQty, CanbackQty: @asset_picking_entry.CanbackQty, Code: @asset_picking_entry.Code, FSrcFbillno: @asset_picking_entry.FSrcFbillno, FSrcFseq: @asset_picking_entry.FSrcFseq, PickingFor: @asset_picking_entry.PickingFor, Picking_Amount: @asset_picking_entry.Picking_Amount, Picking_seat: @asset_picking_entry.Picking_seat, Unit: @asset_picking_entry.Unit, name: @asset_picking_entry.name } }
    assert_redirected_to asset_picking_entry_url(@asset_picking_entry)
  end

  test "should destroy asset_picking_entry" do
    assert_difference('AssetPickingEntry.count', -1) do
      delete asset_picking_entry_url(@asset_picking_entry)
    end

    assert_redirected_to asset_picking_entries_url
  end
end
