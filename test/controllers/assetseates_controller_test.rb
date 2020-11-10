require 'test_helper'

class AssetseatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assetseate = assetseates(:one)
  end

  test "should get index" do
    get assetseates_url
    assert_response :success
  end

  test "should get new" do
    get new_assetseate_url
    assert_response :success
  end

  test "should create assetseate" do
    assert_difference('Assetseate.count') do
      post assetseates_url, params: { assetseate: { Assetseatecode: @assetseate.Assetseatecode, Description: @assetseate.Description, Name: @assetseate.Name, Orgainize_id: @assetseate.Orgainize_id } }
    end

    assert_redirected_to assetseate_url(Assetseate.last)
  end

  test "should show assetseate" do
    get assetseate_url(@assetseate)
    assert_response :success
  end

  test "should get edit" do
    get edit_assetseate_url(@assetseate)
    assert_response :success
  end

  test "should update assetseate" do
    patch assetseate_url(@assetseate), params: { assetseate: { Assetseatecode: @assetseate.Assetseatecode, Description: @assetseate.Description, Name: @assetseate.Name, Orgainize_id: @assetseate.Orgainize_id } }
    assert_redirected_to assetseate_url(@assetseate)
  end

  test "should destroy assetseate" do
    assert_difference('Assetseate.count', -1) do
      delete assetseate_url(@assetseate)
    end

    assert_redirected_to assetseates_url
  end
end
