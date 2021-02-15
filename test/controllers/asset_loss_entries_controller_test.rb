require 'test_helper'

class AssetLossEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset_loss_entry = asset_loss_entries(:one)
  end

  test "should get index" do
    get asset_loss_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_loss_entry_url
    assert_response :success
  end

  test "should create asset_loss_entry" do
    assert_difference('AssetLossEntry.count') do
      post asset_loss_entries_url, params: { asset_loss_entry: { Actual_User: @asset_loss_entry.Actual_User, Actual_dept: @asset_loss_entry.Actual_dept, Actual_seat: @asset_loss_entry.Actual_seat, Asset_Loss_id: @asset_loss_entry.Asset_Loss_id, Asset_type: @asset_loss_entry.Asset_type, BookQty: @asset_loss_entry.BookQty, Book_User: @asset_loss_entry.Book_User, Book_dept: @asset_loss_entry.Book_dept, Book_seat: @asset_loss_entry.Book_seat, Code: @asset_loss_entry.Code, CountQty: @asset_loss_entry.CountQty, FSrcFbillno: @asset_loss_entry.FSrcFbillno, FSrcFseq: @asset_loss_entry.FSrcFseq, LossQty: @asset_loss_entry.LossQty, Unit: @asset_loss_entry.Unit, fseq: @asset_loss_entry.fseq, name: @asset_loss_entry.name } }
    end

    assert_redirected_to asset_loss_entry_url(AssetLossEntry.last)
  end

  test "should show asset_loss_entry" do
    get asset_loss_entry_url(@asset_loss_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_loss_entry_url(@asset_loss_entry)
    assert_response :success
  end

  test "should update asset_loss_entry" do
    patch asset_loss_entry_url(@asset_loss_entry), params: { asset_loss_entry: { Actual_User: @asset_loss_entry.Actual_User, Actual_dept: @asset_loss_entry.Actual_dept, Actual_seat: @asset_loss_entry.Actual_seat, Asset_Loss_id: @asset_loss_entry.Asset_Loss_id, Asset_type: @asset_loss_entry.Asset_type, BookQty: @asset_loss_entry.BookQty, Book_User: @asset_loss_entry.Book_User, Book_dept: @asset_loss_entry.Book_dept, Book_seat: @asset_loss_entry.Book_seat, Code: @asset_loss_entry.Code, CountQty: @asset_loss_entry.CountQty, FSrcFbillno: @asset_loss_entry.FSrcFbillno, FSrcFseq: @asset_loss_entry.FSrcFseq, LossQty: @asset_loss_entry.LossQty, Unit: @asset_loss_entry.Unit, fseq: @asset_loss_entry.fseq, name: @asset_loss_entry.name } }
    assert_redirected_to asset_loss_entry_url(@asset_loss_entry)
  end

  test "should destroy asset_loss_entry" do
    assert_difference('AssetLossEntry.count', -1) do
      delete asset_loss_entry_url(@asset_loss_entry)
    end

    assert_redirected_to asset_loss_entries_url
  end
end
