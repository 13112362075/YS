require 'test_helper'

class AssetRecoveryEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset_recovery_entry = asset_recovery_entries(:one)
  end

  test "should get index" do
    get asset_recovery_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_recovery_entry_url
    assert_response :success
  end

  test "should create asset_recovery_entry" do
    assert_difference('AssetRecoveryEntry.count') do
      post asset_recovery_entries_url, params: { asset_recovery_entry: { Amount_Returnable: @asset_recovery_entry.Amount_Returnable, Amount_returned: @asset_recovery_entry.Amount_returned, Asset_recovery_id: @asset_recovery_entry.Asset_recovery_id, Asset_status: @asset_recovery_entry.Asset_status, Asset_type: @asset_recovery_entry.Asset_type, Code: @asset_recovery_entry.Code, Requisition_Amount: @asset_recovery_entry.Requisition_Amount, Requisition_Department: @asset_recovery_entry.Requisition_Department, Requisition_Employeeld: @asset_recovery_entry.Requisition_Employeeld, Requisition_use: @asset_recovery_entry.Requisition_use, Unit: @asset_recovery_entry.Unit, name: @asset_recovery_entry.name } }
    end

    assert_redirected_to asset_recovery_entry_url(AssetRecoveryEntry.last)
  end

  test "should show asset_recovery_entry" do
    get asset_recovery_entry_url(@asset_recovery_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_recovery_entry_url(@asset_recovery_entry)
    assert_response :success
  end

  test "should update asset_recovery_entry" do
    patch asset_recovery_entry_url(@asset_recovery_entry), params: { asset_recovery_entry: { Amount_Returnable: @asset_recovery_entry.Amount_Returnable, Amount_returned: @asset_recovery_entry.Amount_returned, Asset_recovery_id: @asset_recovery_entry.Asset_recovery_id, Asset_status: @asset_recovery_entry.Asset_status, Asset_type: @asset_recovery_entry.Asset_type, Code: @asset_recovery_entry.Code, Requisition_Amount: @asset_recovery_entry.Requisition_Amount, Requisition_Department: @asset_recovery_entry.Requisition_Department, Requisition_Employeeld: @asset_recovery_entry.Requisition_Employeeld, Requisition_use: @asset_recovery_entry.Requisition_use, Unit: @asset_recovery_entry.Unit, name: @asset_recovery_entry.name } }
    assert_redirected_to asset_recovery_entry_url(@asset_recovery_entry)
  end

  test "should destroy asset_recovery_entry" do
    assert_difference('AssetRecoveryEntry.count', -1) do
      delete asset_recovery_entry_url(@asset_recovery_entry)
    end

    assert_redirected_to asset_recovery_entries_url
  end
end
