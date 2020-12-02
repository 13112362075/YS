require 'test_helper'

class AssetScrappingEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset_scrapping_entry = asset_scrapping_entries(:one)
  end

  test "should get index" do
    get asset_scrapping_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_scrapping_entry_url
    assert_response :success
  end

  test "should create asset_scrapping_entry" do
    assert_difference('AssetScrappingEntry.count') do
      post asset_scrapping_entries_url, params: { asset_scrapping_entry: { Amount: @asset_scrapping_entry.Amount, Asset_Scrapping_id: @asset_scrapping_entry.Asset_Scrapping_id, Asset_seat: @asset_scrapping_entry.Asset_seat, Code: @asset_scrapping_entry.Code, Name: @asset_scrapping_entry.Name, Scrapping_Amount: @asset_scrapping_entry.Scrapping_Amount, Unit: @asset_scrapping_entry.Unit } }
    end

    assert_redirected_to asset_scrapping_entry_url(AssetScrappingEntry.last)
  end

  test "should show asset_scrapping_entry" do
    get asset_scrapping_entry_url(@asset_scrapping_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_scrapping_entry_url(@asset_scrapping_entry)
    assert_response :success
  end

  test "should update asset_scrapping_entry" do
    patch asset_scrapping_entry_url(@asset_scrapping_entry), params: { asset_scrapping_entry: { Amount: @asset_scrapping_entry.Amount, Asset_Scrapping_id: @asset_scrapping_entry.Asset_Scrapping_id, Asset_seat: @asset_scrapping_entry.Asset_seat, Code: @asset_scrapping_entry.Code, Name: @asset_scrapping_entry.Name, Scrapping_Amount: @asset_scrapping_entry.Scrapping_Amount, Unit: @asset_scrapping_entry.Unit } }
    assert_redirected_to asset_scrapping_entry_url(@asset_scrapping_entry)
  end

  test "should destroy asset_scrapping_entry" do
    assert_difference('AssetScrappingEntry.count', -1) do
      delete asset_scrapping_entry_url(@asset_scrapping_entry)
    end

    assert_redirected_to asset_scrapping_entries_url
  end
end
