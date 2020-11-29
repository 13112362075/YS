require 'test_helper'

class AssetRecoveriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset_recovery = asset_recoveries(:one)
  end

  test "should get index" do
    get asset_recoveries_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_recovery_url
    assert_response :success
  end

  test "should create asset_recovery" do
    assert_difference('AssetRecovery.count') do
      post asset_recoveries_url, params: { asset_recovery: { Documentnumber: @asset_recovery.Documentnumber, Requisition_Date: @asset_recovery.Requisition_Date, Type_of_business: @asset_recovery.Type_of_business } }
    end

    assert_redirected_to asset_recovery_url(AssetRecovery.last)
  end

  test "should show asset_recovery" do
    get asset_recovery_url(@asset_recovery)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_recovery_url(@asset_recovery)
    assert_response :success
  end

  test "should update asset_recovery" do
    patch asset_recovery_url(@asset_recovery), params: { asset_recovery: { Documentnumber: @asset_recovery.Documentnumber, Requisition_Date: @asset_recovery.Requisition_Date, Type_of_business: @asset_recovery.Type_of_business } }
    assert_redirected_to asset_recovery_url(@asset_recovery)
  end

  test "should destroy asset_recovery" do
    assert_difference('AssetRecovery.count', -1) do
      delete asset_recovery_url(@asset_recovery)
    end

    assert_redirected_to asset_recoveries_url
  end
end
