require 'test_helper'

class AssetTurnoverDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset_turnover_detail = asset_turnover_details(:one)
  end

  test "should get index" do
    get asset_turnover_details_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_turnover_detail_url
    assert_response :success
  end

  test "should create asset_turnover_detail" do
    assert_difference('AssetTurnoverDetail.count') do
      post asset_turnover_details_url, params: { asset_turnover_detail: { Borrowed_To_id: @asset_turnover_detail.Borrowed_To_id, Borrowing_Department: @asset_turnover_detail.Borrowing_Department, Borrowing_date: @asset_turnover_detail.Borrowing_date, Document_number: @asset_turnover_detail.Document_number, Loaner: @asset_turnover_detail.Loaner } }
    end

    assert_redirected_to asset_turnover_detail_url(AssetTurnoverDetail.last)
  end

  test "should show asset_turnover_detail" do
    get asset_turnover_detail_url(@asset_turnover_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_turnover_detail_url(@asset_turnover_detail)
    assert_response :success
  end

  test "should update asset_turnover_detail" do
    patch asset_turnover_detail_url(@asset_turnover_detail), params: { asset_turnover_detail: { Borrowed_To_id: @asset_turnover_detail.Borrowed_To_id, Borrowing_Department: @asset_turnover_detail.Borrowing_Department, Borrowing_date: @asset_turnover_detail.Borrowing_date, Document_number: @asset_turnover_detail.Document_number, Loaner: @asset_turnover_detail.Loaner } }
    assert_redirected_to asset_turnover_detail_url(@asset_turnover_detail)
  end

  test "should destroy asset_turnover_detail" do
    assert_difference('AssetTurnoverDetail.count', -1) do
      delete asset_turnover_detail_url(@asset_turnover_detail)
    end

    assert_redirected_to asset_turnover_details_url
  end
end
