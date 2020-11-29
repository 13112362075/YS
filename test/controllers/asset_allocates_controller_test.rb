require 'test_helper'

class AssetAllocatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset_allocate = asset_allocates(:one)
  end

  test "should get index" do
    get asset_allocates_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_allocate_url
    assert_response :success
  end

  test "should create asset_allocate" do
    assert_difference('AssetAllocate.count') do
      post asset_allocates_url, params: { asset_allocate: { Allocate_reason: @asset_allocate.Allocate_reason, Bring_in_Confirm: @asset_allocate.Bring_in_Confirm, Bring_in_Number: @asset_allocate.Bring_in_Number, Bring_in_to_id: @asset_allocate.Bring_in_to_id, Document_number: @asset_allocate.Document_number, Pull_up_date: @asset_allocate.Pull_up_date, Pull_up_to_id: @asset_allocate.Pull_up_to_id } }
    end

    assert_redirected_to asset_allocate_url(AssetAllocate.last)
  end

  test "should show asset_allocate" do
    get asset_allocate_url(@asset_allocate)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_allocate_url(@asset_allocate)
    assert_response :success
  end

  test "should update asset_allocate" do
    patch asset_allocate_url(@asset_allocate), params: { asset_allocate: { Allocate_reason: @asset_allocate.Allocate_reason, Bring_in_Confirm: @asset_allocate.Bring_in_Confirm, Bring_in_Number: @asset_allocate.Bring_in_Number, Bring_in_to_id: @asset_allocate.Bring_in_to_id, Document_number: @asset_allocate.Document_number, Pull_up_date: @asset_allocate.Pull_up_date, Pull_up_to_id: @asset_allocate.Pull_up_to_id } }
    assert_redirected_to asset_allocate_url(@asset_allocate)
  end

  test "should destroy asset_allocate" do
    assert_difference('AssetAllocate.count', -1) do
      delete asset_allocate_url(@asset_allocate)
    end

    assert_redirected_to asset_allocates_url
  end
end
