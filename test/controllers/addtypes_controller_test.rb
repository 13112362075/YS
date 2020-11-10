require 'test_helper'

class AddtypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @addtype = addtypes(:one)
  end

  test "should get index" do
    get addtypes_url
    assert_response :success
  end

  test "should get new" do
    get new_addtype_url
    assert_response :success
  end

  test "should create addtype" do
    assert_difference('Addtype.count') do
      post addtypes_url, params: { addtype: { Addtypecode: @addtype.Addtypecode, Description: @addtype.Description, Name: @addtype.Name, Orgainize_id: @addtype.Orgainize_id } }
    end

    assert_redirected_to addtype_url(Addtype.last)
  end

  test "should show addtype" do
    get addtype_url(@addtype)
    assert_response :success
  end

  test "should get edit" do
    get edit_addtype_url(@addtype)
    assert_response :success
  end

  test "should update addtype" do
    patch addtype_url(@addtype), params: { addtype: { Addtypecode: @addtype.Addtypecode, Description: @addtype.Description, Name: @addtype.Name, Orgainize_id: @addtype.Orgainize_id } }
    assert_redirected_to addtype_url(@addtype)
  end

  test "should destroy addtype" do
    assert_difference('Addtype.count', -1) do
      delete addtype_url(@addtype)
    end

    assert_redirected_to addtypes_url
  end
end
