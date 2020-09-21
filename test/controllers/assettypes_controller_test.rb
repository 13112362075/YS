require 'test_helper'

class AssettypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assettype = assettypes(:one)
  end

  test "should get index" do
    get assettypes_url
    assert_response :success
  end

  test "should get new" do
    get new_assettype_url
    assert_response :success
  end

  test "should create assettype" do
    assert_difference('Assettype.count') do
      post assettypes_url, params: { assettype: { Assettypecode: @assettype.Assettypecode, Name: @assettype.Name, Orgainize_id: @assettype.Orgainize_id, description: @assettype.description } }
    end

    assert_redirected_to assettype_url(Assettype.last)
  end

  test "should show assettype" do
    get assettype_url(@assettype)
    assert_response :success
  end

  test "should get edit" do
    get edit_assettype_url(@assettype)
    assert_response :success
  end

  test "should update assettype" do
    patch assettype_url(@assettype), params: { assettype: { Assettypecode: @assettype.Assettypecode, Name: @assettype.Name, Orgainize_id: @assettype.Orgainize_id, description: @assettype.description } }
    assert_redirected_to assettype_url(@assettype)
  end

  test "should destroy assettype" do
    assert_difference('Assettype.count', -1) do
      delete assettype_url(@assettype)
    end

    assert_redirected_to assettypes_url
  end
end
