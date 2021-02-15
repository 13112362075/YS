require 'test_helper'

class AssetLossesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset_loss = asset_losses(:one)
  end

  test "should get index" do
    get asset_losses_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_loss_url
    assert_response :success
  end

  test "should create asset_loss" do
    assert_difference('AssetLoss.count') do
      post asset_losses_url, params: { asset_loss: { APPROVEDATE: @asset_loss.APPROVEDATE, Approver: @asset_loss.Approver, BillNo: @asset_loss.BillNo, CREATEDATE: @asset_loss.CREATEDATE, Creator: @asset_loss.Creator, description: @asset_loss.description, fbillstatus: @asset_loss.fbillstatus, fdate: @asset_loss.fdate } }
    end

    assert_redirected_to asset_loss_url(AssetLoss.last)
  end

  test "should show asset_loss" do
    get asset_loss_url(@asset_loss)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_loss_url(@asset_loss)
    assert_response :success
  end

  test "should update asset_loss" do
    patch asset_loss_url(@asset_loss), params: { asset_loss: { APPROVEDATE: @asset_loss.APPROVEDATE, Approver: @asset_loss.Approver, BillNo: @asset_loss.BillNo, CREATEDATE: @asset_loss.CREATEDATE, Creator: @asset_loss.Creator, description: @asset_loss.description, fbillstatus: @asset_loss.fbillstatus, fdate: @asset_loss.fdate } }
    assert_redirected_to asset_loss_url(@asset_loss)
  end

  test "should destroy asset_loss" do
    assert_difference('AssetLoss.count', -1) do
      delete asset_loss_url(@asset_loss)
    end

    assert_redirected_to asset_losses_url
  end
end
