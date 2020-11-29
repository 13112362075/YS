require 'test_helper'

class AssetAllocateEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset_allocate_entry = asset_allocate_entries(:one)
  end

  test "should get index" do
    get asset_allocate_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_allocate_entry_url
    assert_response :success
  end

  test "should create asset_allocate_entry" do
    assert_difference('AssetAllocateEntry.count') do
      post asset_allocate_entries_url, params: { asset_allocate_entry: { Amount: @asset_allocate_entry.Amount, Asset_seat: @asset_allocate_entry.Asset_seat, Code: @asset_allocate_entry.Code, Transfer: @asset_allocate_entry.Transfer, Unit: @asset_allocate_entry.Unit, name: @asset_allocate_entry.name, out: @asset_allocate_entry.out, quantity: @asset_allocate_entry.quantity } }
    end

    assert_redirected_to asset_allocate_entry_url(AssetAllocateEntry.last)
  end

  test "should show asset_allocate_entry" do
    get asset_allocate_entry_url(@asset_allocate_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_allocate_entry_url(@asset_allocate_entry)
    assert_response :success
  end

  test "should update asset_allocate_entry" do
    patch asset_allocate_entry_url(@asset_allocate_entry), params: { asset_allocate_entry: { Amount: @asset_allocate_entry.Amount, Asset_seat: @asset_allocate_entry.Asset_seat, Code: @asset_allocate_entry.Code, Transfer: @asset_allocate_entry.Transfer, Unit: @asset_allocate_entry.Unit, name: @asset_allocate_entry.name, out: @asset_allocate_entry.out, quantity: @asset_allocate_entry.quantity } }
    assert_redirected_to asset_allocate_entry_url(@asset_allocate_entry)
  end

  test "should destroy asset_allocate_entry" do
    assert_difference('AssetAllocateEntry.count', -1) do
      delete asset_allocate_entry_url(@asset_allocate_entry)
    end

    assert_redirected_to asset_allocate_entries_url
  end
end
