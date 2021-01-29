require 'test_helper'

class AssetDisposalEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset_disposal_entry = asset_disposal_entries(:one)
  end

  test "should get index" do
    get asset_disposal_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_disposal_entry_url
    assert_response :success
  end

  test "should create asset_disposal_entry" do
    assert_difference('AssetDisposalEntry.count') do
      post asset_disposal_entries_url, params: { asset_disposal_entry: { Amount: @asset_disposal_entry.Amount, Asset_seat: @asset_disposal_entry.Asset_seat, Code: @asset_disposal_entry.Code, DisposeAmount: @asset_disposal_entry.DisposeAmount, DisposePrice: @asset_disposal_entry.DisposePrice, Unit: @asset_disposal_entry.Unit, name: @asset_disposal_entry.name } }
    end

    assert_redirected_to asset_disposal_entry_url(AssetDisposalEntry.last)
  end

  test "should show asset_disposal_entry" do
    get asset_disposal_entry_url(@asset_disposal_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_disposal_entry_url(@asset_disposal_entry)
    assert_response :success
  end

  test "should update asset_disposal_entry" do
    patch asset_disposal_entry_url(@asset_disposal_entry), params: { asset_disposal_entry: { Amount: @asset_disposal_entry.Amount, Asset_seat: @asset_disposal_entry.Asset_seat, Code: @asset_disposal_entry.Code, DisposeAmount: @asset_disposal_entry.DisposeAmount, DisposePrice: @asset_disposal_entry.DisposePrice, Unit: @asset_disposal_entry.Unit, name: @asset_disposal_entry.name } }
    assert_redirected_to asset_disposal_entry_url(@asset_disposal_entry)
  end

  test "should destroy asset_disposal_entry" do
    assert_difference('AssetDisposalEntry.count', -1) do
      delete asset_disposal_entry_url(@asset_disposal_entry)
    end

    assert_redirected_to asset_disposal_entries_url
  end
end
