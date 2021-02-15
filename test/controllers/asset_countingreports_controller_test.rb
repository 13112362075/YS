require 'test_helper'

class AssetCountingreportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset_countingreport = asset_countingreports(:one)
  end

  test "should get index" do
    get asset_countingreports_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_countingreport_url
    assert_response :success
  end

  test "should create asset_countingreport" do
    assert_difference('AssetCountingreport.count') do
      post asset_countingreports_url, params: { asset_countingreport: { APPROVEDATE: @asset_countingreport.APPROVEDATE, Approver: @asset_countingreport.Approver, BillNo: @asset_countingreport.BillNo, CREATEDATE: @asset_countingreport.CREATEDATE, Creator: @asset_countingreport.Creator, description: @asset_countingreport.description, fbillstatus: @asset_countingreport.fbillstatus, fdate: @asset_countingreport.fdate } }
    end

    assert_redirected_to asset_countingreport_url(AssetCountingreport.last)
  end

  test "should show asset_countingreport" do
    get asset_countingreport_url(@asset_countingreport)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_countingreport_url(@asset_countingreport)
    assert_response :success
  end

  test "should update asset_countingreport" do
    patch asset_countingreport_url(@asset_countingreport), params: { asset_countingreport: { APPROVEDATE: @asset_countingreport.APPROVEDATE, Approver: @asset_countingreport.Approver, BillNo: @asset_countingreport.BillNo, CREATEDATE: @asset_countingreport.CREATEDATE, Creator: @asset_countingreport.Creator, description: @asset_countingreport.description, fbillstatus: @asset_countingreport.fbillstatus, fdate: @asset_countingreport.fdate } }
    assert_redirected_to asset_countingreport_url(@asset_countingreport)
  end

  test "should destroy asset_countingreport" do
    assert_difference('AssetCountingreport.count', -1) do
      delete asset_countingreport_url(@asset_countingreport)
    end

    assert_redirected_to asset_countingreports_url
  end
end
