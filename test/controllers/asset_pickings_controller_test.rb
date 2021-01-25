require 'test_helper'

class AssetPickingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset_picking = asset_pickings(:one)
  end

  test "should get index" do
    get asset_pickings_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_picking_url
    assert_response :success
  end

  test "should create asset_picking" do
    assert_difference('AssetPicking.count') do
      post asset_pickings_url, params: { asset_picking: { ApproveDate: @asset_picking.ApproveDate, Approver: @asset_picking.Approver, CreateDate: @asset_picking.CreateDate, Creator: @asset_picking.Creator, FBillno: @asset_picking.FBillno, Fbillstatus: @asset_picking.Fbillstatus, Picking_Date: @asset_picking.Picking_Date, Picking_Dept: @asset_picking.Picking_Dept, Picking_Employeeld: @asset_picking.Picking_Employeeld, Type_of_business: @asset_picking.Type_of_business } }
    end

    assert_redirected_to asset_picking_url(AssetPicking.last)
  end

  test "should show asset_picking" do
    get asset_picking_url(@asset_picking)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_picking_url(@asset_picking)
    assert_response :success
  end

  test "should update asset_picking" do
    patch asset_picking_url(@asset_picking), params: { asset_picking: { ApproveDate: @asset_picking.ApproveDate, Approver: @asset_picking.Approver, CreateDate: @asset_picking.CreateDate, Creator: @asset_picking.Creator, FBillno: @asset_picking.FBillno, Fbillstatus: @asset_picking.Fbillstatus, Picking_Date: @asset_picking.Picking_Date, Picking_Dept: @asset_picking.Picking_Dept, Picking_Employeeld: @asset_picking.Picking_Employeeld, Type_of_business: @asset_picking.Type_of_business } }
    assert_redirected_to asset_picking_url(@asset_picking)
  end

  test "should destroy asset_picking" do
    assert_difference('AssetPicking.count', -1) do
      delete asset_picking_url(@asset_picking)
    end

    assert_redirected_to asset_pickings_url
  end
end
