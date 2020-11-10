require 'test_helper'

class UsestatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usestate = usestates(:one)
  end

  test "should get index" do
    get usestates_url
    assert_response :success
  end

  test "should get new" do
    get new_usestate_url
    assert_response :success
  end

  test "should create usestate" do
    assert_difference('Usestate.count') do
      post usestates_url, params: { usestate: { Description: @usestate.Description, Name: @usestate.Name, Orgainize_id: @usestate.Orgainize_id, Usestatecode: @usestate.Usestatecode } }
    end

    assert_redirected_to usestate_url(Usestate.last)
  end

  test "should show usestate" do
    get usestate_url(@usestate)
    assert_response :success
  end

  test "should get edit" do
    get edit_usestate_url(@usestate)
    assert_response :success
  end

  test "should update usestate" do
    patch usestate_url(@usestate), params: { usestate: { Description: @usestate.Description, Name: @usestate.Name, Orgainize_id: @usestate.Orgainize_id, Usestatecode: @usestate.Usestatecode } }
    assert_redirected_to usestate_url(@usestate)
  end

  test "should destroy usestate" do
    assert_difference('Usestate.count', -1) do
      delete usestate_url(@usestate)
    end

    assert_redirected_to usestates_url
  end
end
