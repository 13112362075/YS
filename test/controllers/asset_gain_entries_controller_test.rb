require 'test_helper'

class AssetGainEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset_gain_entry = asset_gain_entries(:one)
  end

  test "should get index" do
    get asset_gain_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_gain_entry_url
    assert_response :success
  end

  test "should create asset_gain_entry" do
    assert_difference('AssetGainEntry.count') do
      post asset_gain_entries_url, params: { asset_gain_entry: { Actual_User: @asset_gain_entry.Actual_User, Actual_dept: @asset_gain_entry.Actual_dept, Actual_seat: @asset_gain_entry.Actual_seat, Asset_Gain_id: @asset_gain_entry.Asset_Gain_id, Asset_type: @asset_gain_entry.Asset_type, BookQty: @asset_gain_entry.BookQty, Book_User: @asset_gain_entry.Book_User, Book_dept: @asset_gain_entry.Book_dept, Book_seat: @asset_gain_entry.Book_seat, Code: @asset_gain_entry.Code, CountQty: @asset_gain_entry.CountQty, FSrcFbillno: @asset_gain_entry.FSrcFbillno, FSrcFseq: @asset_gain_entry.FSrcFseq, GainQty: @asset_gain_entry.GainQty, Unit: @asset_gain_entry.Unit, fseq: @asset_gain_entry.fseq, name: @asset_gain_entry.name } }
    end

    assert_redirected_to asset_gain_entry_url(AssetGainEntry.last)
  end

  test "should show asset_gain_entry" do
    get asset_gain_entry_url(@asset_gain_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_gain_entry_url(@asset_gain_entry)
    assert_response :success
  end

  test "should update asset_gain_entry" do
    patch asset_gain_entry_url(@asset_gain_entry), params: { asset_gain_entry: { Actual_User: @asset_gain_entry.Actual_User, Actual_dept: @asset_gain_entry.Actual_dept, Actual_seat: @asset_gain_entry.Actual_seat, Asset_Gain_id: @asset_gain_entry.Asset_Gain_id, Asset_type: @asset_gain_entry.Asset_type, BookQty: @asset_gain_entry.BookQty, Book_User: @asset_gain_entry.Book_User, Book_dept: @asset_gain_entry.Book_dept, Book_seat: @asset_gain_entry.Book_seat, Code: @asset_gain_entry.Code, CountQty: @asset_gain_entry.CountQty, FSrcFbillno: @asset_gain_entry.FSrcFbillno, FSrcFseq: @asset_gain_entry.FSrcFseq, GainQty: @asset_gain_entry.GainQty, Unit: @asset_gain_entry.Unit, fseq: @asset_gain_entry.fseq, name: @asset_gain_entry.name } }
    assert_redirected_to asset_gain_entry_url(@asset_gain_entry)
  end

  test "should destroy asset_gain_entry" do
    assert_difference('AssetGainEntry.count', -1) do
      delete asset_gain_entry_url(@asset_gain_entry)
    end

    assert_redirected_to asset_gain_entries_url
  end
end
