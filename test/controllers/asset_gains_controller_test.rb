require 'test_helper'

class AssetGainsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset_gain = asset_gains(:one)
  end

  test "should get index" do
    get asset_gains_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_gain_url
    assert_response :success
  end

  test "should create asset_gain" do
    assert_difference('AssetGain.count') do
      post asset_gains_url, params: { asset_gain: { APPROVEDATE: @asset_gain.APPROVEDATE, Approver: @asset_gain.Approver, BillNo: @asset_gain.BillNo, CREATEDATE: @asset_gain.CREATEDATE, Creator: @asset_gain.Creator, description: @asset_gain.description, fbillstatus: @asset_gain.fbillstatus, fdate: @asset_gain.fdate } }
    end

    assert_redirected_to asset_gain_url(AssetGain.last)
  end

  test "should show asset_gain" do
    get asset_gain_url(@asset_gain)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_gain_url(@asset_gain)
    assert_response :success
  end

  test "should update asset_gain" do
    patch asset_gain_url(@asset_gain), params: { asset_gain: { APPROVEDATE: @asset_gain.APPROVEDATE, Approver: @asset_gain.Approver, BillNo: @asset_gain.BillNo, CREATEDATE: @asset_gain.CREATEDATE, Creator: @asset_gain.Creator, description: @asset_gain.description, fbillstatus: @asset_gain.fbillstatus, fdate: @asset_gain.fdate } }
    assert_redirected_to asset_gain_url(@asset_gain)
  end

  test "should destroy asset_gain" do
    assert_difference('AssetGain.count', -1) do
      delete asset_gain_url(@asset_gain)
    end

    assert_redirected_to asset_gains_url
  end
end
