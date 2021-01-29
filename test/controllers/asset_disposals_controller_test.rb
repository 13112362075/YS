require 'test_helper'

class AssetDisposalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset_disposal = asset_disposals(:one)
  end

  test "should get index" do
    get asset_disposals_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_disposal_url
    assert_response :success
  end

  test "should create asset_disposal" do
    assert_difference('AssetDisposal.count') do
      post asset_disposals_url, params: { asset_disposal: { ApproveDate: @asset_disposal.ApproveDate, Approver: @asset_disposal.Approver, CreateDate: @asset_disposal.CreateDate, Creator: @asset_disposal.Creator, DisposeDate: @asset_disposal.DisposeDate, DisposeReason: @asset_disposal.DisposeReason, Disposemethod: @asset_disposal.Disposemethod, FBillno: @asset_disposal.FBillno, Fbillstatus: @asset_disposal.Fbillstatus } }
    end

    assert_redirected_to asset_disposal_url(AssetDisposal.last)
  end

  test "should show asset_disposal" do
    get asset_disposal_url(@asset_disposal)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_disposal_url(@asset_disposal)
    assert_response :success
  end

  test "should update asset_disposal" do
    patch asset_disposal_url(@asset_disposal), params: { asset_disposal: { ApproveDate: @asset_disposal.ApproveDate, Approver: @asset_disposal.Approver, CreateDate: @asset_disposal.CreateDate, Creator: @asset_disposal.Creator, DisposeDate: @asset_disposal.DisposeDate, DisposeReason: @asset_disposal.DisposeReason, Disposemethod: @asset_disposal.Disposemethod, FBillno: @asset_disposal.FBillno, Fbillstatus: @asset_disposal.Fbillstatus } }
    assert_redirected_to asset_disposal_url(@asset_disposal)
  end

  test "should destroy asset_disposal" do
    assert_difference('AssetDisposal.count', -1) do
      delete asset_disposal_url(@asset_disposal)
    end

    assert_redirected_to asset_disposals_url
  end
end
