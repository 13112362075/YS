require 'test_helper'

class AssetCountingreportEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset_countingreport_entry = asset_countingreport_entries(:one)
  end

  test "should get index" do
    get asset_countingreport_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_countingreport_entry_url
    assert_response :success
  end

  test "should create asset_countingreport_entry" do
    assert_difference('AssetCountingreportEntry.count') do
      post asset_countingreport_entries_url, params: { asset_countingreport_entry: { Asset_Countingreport_id: @asset_countingreport_entry.Asset_Countingreport_id, Asset_status: @asset_countingreport_entry.Asset_status, Asset_type: @asset_countingreport_entry.Asset_type, BookQty: @asset_countingreport_entry.BookQty, Book_User: @asset_countingreport_entry.Book_User, Book_dept: @asset_countingreport_entry.Book_dept, Book_seat: @asset_countingreport_entry.Book_seat, Code: @asset_countingreport_entry.Code, CountDate: @asset_countingreport_entry.CountDate, CountQty: @asset_countingreport_entry.CountQty, Headnote: @asset_countingreport_entry.Headnote, InventUser: @asset_countingreport_entry.InventUser, Invent_dept: @asset_countingreport_entry.Invent_dept, Invent_seat: @asset_countingreport_entry.Invent_seat, Model: @asset_countingreport_entry.Model, Unit: @asset_countingreport_entry.Unit, Variance: @asset_countingreport_entry.Variance, fseq: @asset_countingreport_entry.fseq, name: @asset_countingreport_entry.name } }
    end

    assert_redirected_to asset_countingreport_entry_url(AssetCountingreportEntry.last)
  end

  test "should show asset_countingreport_entry" do
    get asset_countingreport_entry_url(@asset_countingreport_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_countingreport_entry_url(@asset_countingreport_entry)
    assert_response :success
  end

  test "should update asset_countingreport_entry" do
    patch asset_countingreport_entry_url(@asset_countingreport_entry), params: { asset_countingreport_entry: { Asset_Countingreport_id: @asset_countingreport_entry.Asset_Countingreport_id, Asset_status: @asset_countingreport_entry.Asset_status, Asset_type: @asset_countingreport_entry.Asset_type, BookQty: @asset_countingreport_entry.BookQty, Book_User: @asset_countingreport_entry.Book_User, Book_dept: @asset_countingreport_entry.Book_dept, Book_seat: @asset_countingreport_entry.Book_seat, Code: @asset_countingreport_entry.Code, CountDate: @asset_countingreport_entry.CountDate, CountQty: @asset_countingreport_entry.CountQty, Headnote: @asset_countingreport_entry.Headnote, InventUser: @asset_countingreport_entry.InventUser, Invent_dept: @asset_countingreport_entry.Invent_dept, Invent_seat: @asset_countingreport_entry.Invent_seat, Model: @asset_countingreport_entry.Model, Unit: @asset_countingreport_entry.Unit, Variance: @asset_countingreport_entry.Variance, fseq: @asset_countingreport_entry.fseq, name: @asset_countingreport_entry.name } }
    assert_redirected_to asset_countingreport_entry_url(@asset_countingreport_entry)
  end

  test "should destroy asset_countingreport_entry" do
    assert_difference('AssetCountingreportEntry.count', -1) do
      delete asset_countingreport_entry_url(@asset_countingreport_entry)
    end

    assert_redirected_to asset_countingreport_entries_url
  end
end
