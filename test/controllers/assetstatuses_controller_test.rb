require 'test_helper'

class AssetstatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assetstatus = assetstatuses(:one)
  end

  test "should get index" do
    get assetstatuses_url
    assert_response :success
  end

  test "should get new" do
    get new_assetstatus_url
    assert_response :success
  end

  test "should create assetstatus" do
    assert_difference('Assetstatus.count') do
      post assetstatuses_url, params: { assetstatus: { Assetstatuscode: @assetstatus.Assetstatuscode, Name: @assetstatus.Name, Orgainize_id: @assetstatus.Orgainize_id, description: @assetstatus.description } }
    end

    assert_redirected_to assetstatus_url(Assetstatus.last)
  end

  test "should show assetstatus" do
    get assetstatus_url(@assetstatus)
    assert_response :success
  end

  test "should get edit" do
    get edit_assetstatus_url(@assetstatus)
    assert_response :success
  end

  test "should update assetstatus" do
    patch assetstatus_url(@assetstatus), params: { assetstatus: { Assetstatuscode: @assetstatus.Assetstatuscode, Name: @assetstatus.Name, Orgainize_id: @assetstatus.Orgainize_id, description: @assetstatus.description } }
    assert_redirected_to assetstatus_url(@assetstatus)
  end

  test "should destroy assetstatus" do
    assert_difference('Assetstatus.count', -1) do
      delete assetstatus_url(@assetstatus)
    end

    assert_redirected_to assetstatuses_url
  end
end
