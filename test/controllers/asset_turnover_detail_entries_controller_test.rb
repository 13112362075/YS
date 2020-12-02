require 'test_helper'

class AssetTurnoverDetailEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset_turnover_detail_entry = asset_turnover_detail_entries(:one)
  end

  test "should get index" do
    get asset_turnover_detail_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_turnover_detail_entry_url
    assert_response :success
  end

  test "should create asset_turnover_detail_entry" do
    assert_difference('AssetTurnoverDetailEntry.count') do
      post asset_turnover_detail_entries_url, params: { asset_turnover_detail_entry: { Amount: @asset_turnover_detail_entry.Amount, AssetTurnoverDetail_id: @asset_turnover_detail_entry.AssetTurnoverDetail_id, Asset_seat: @asset_turnover_detail_entry.Asset_seat, Deptment: @asset_turnover_detail_entry.Deptment, Employeeld: @asset_turnover_detail_entry.Employeeld, Has_Been_returned: @asset_turnover_detail_entry.Has_Been_returned, Last_seat: @asset_turnover_detail_entry.Last_seat, Reasons_for_borrowing: @asset_turnover_detail_entry.Reasons_for_borrowing, Unit: @asset_turnover_detail_entry.Unit, assetcards_Code: @asset_turnover_detail_entry.assetcards_Code, assetcards_name: @asset_turnover_detail_entry.assetcards_name, givebackDate: @asset_turnover_detail_entry.givebackDate, givebackPlanDate: @asset_turnover_detail_entry.givebackPlanDate } }
    end

    assert_redirected_to asset_turnover_detail_entry_url(AssetTurnoverDetailEntry.last)
  end

  test "should show asset_turnover_detail_entry" do
    get asset_turnover_detail_entry_url(@asset_turnover_detail_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_turnover_detail_entry_url(@asset_turnover_detail_entry)
    assert_response :success
  end

  test "should update asset_turnover_detail_entry" do
    patch asset_turnover_detail_entry_url(@asset_turnover_detail_entry), params: { asset_turnover_detail_entry: { Amount: @asset_turnover_detail_entry.Amount, AssetTurnoverDetail_id: @asset_turnover_detail_entry.AssetTurnoverDetail_id, Asset_seat: @asset_turnover_detail_entry.Asset_seat, Deptment: @asset_turnover_detail_entry.Deptment, Employeeld: @asset_turnover_detail_entry.Employeeld, Has_Been_returned: @asset_turnover_detail_entry.Has_Been_returned, Last_seat: @asset_turnover_detail_entry.Last_seat, Reasons_for_borrowing: @asset_turnover_detail_entry.Reasons_for_borrowing, Unit: @asset_turnover_detail_entry.Unit, assetcards_Code: @asset_turnover_detail_entry.assetcards_Code, assetcards_name: @asset_turnover_detail_entry.assetcards_name, givebackDate: @asset_turnover_detail_entry.givebackDate, givebackPlanDate: @asset_turnover_detail_entry.givebackPlanDate } }
    assert_redirected_to asset_turnover_detail_entry_url(@asset_turnover_detail_entry)
  end

  test "should destroy asset_turnover_detail_entry" do
    assert_difference('AssetTurnoverDetailEntry.count', -1) do
      delete asset_turnover_detail_entry_url(@asset_turnover_detail_entry)
    end

    assert_redirected_to asset_turnover_detail_entries_url
  end
end
