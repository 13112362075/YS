require 'test_helper'

class AssetScrappingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset_scrapping = asset_scrappings(:one)
  end

  test "should get index" do
    get asset_scrappings_url
    assert_response :success
  end

  test "should get new" do
    get new_asset_scrapping_url
    assert_response :success
  end

  test "should create asset_scrapping" do
    assert_difference('AssetScrapping.count') do
      post asset_scrappings_url, params: { asset_scrapping: { Addtype: @asset_scrapping.Addtype, Addtype_Reason: @asset_scrapping.Addtype_Reason, Date: @asset_scrapping.Date, Document_number: @asset_scrapping.Document_number } }
    end

    assert_redirected_to asset_scrapping_url(AssetScrapping.last)
  end

  test "should show asset_scrapping" do
    get asset_scrapping_url(@asset_scrapping)
    assert_response :success
  end

  test "should get edit" do
    get edit_asset_scrapping_url(@asset_scrapping)
    assert_response :success
  end

  test "should update asset_scrapping" do
    patch asset_scrapping_url(@asset_scrapping), params: { asset_scrapping: { Addtype: @asset_scrapping.Addtype, Addtype_Reason: @asset_scrapping.Addtype_Reason, Date: @asset_scrapping.Date, Document_number: @asset_scrapping.Document_number } }
    assert_redirected_to asset_scrapping_url(@asset_scrapping)
  end

  test "should destroy asset_scrapping" do
    assert_difference('AssetScrapping.count', -1) do
      delete asset_scrapping_url(@asset_scrapping)
    end

    assert_redirected_to asset_scrappings_url
  end
end
