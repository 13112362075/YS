require 'test_helper'

class AssetaltersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assetalter = assetalters(:one)
  end

  test "should get index" do
    get assetalters_url
    assert_response :success
  end

  test "should get new" do
    get new_assetalter_url
    assert_response :success
  end

  test "should create assetalter" do
    assert_difference('Assetalter.count') do
      post assetalters_url, params: { assetalter: { Alterdate: @assetalter.Alterdate, Code: @assetalter.Code, Fbillno: @assetalter.Fbillno, Reason: @assetalter.Reason, name: @assetalter.name } }
    end

    assert_redirected_to assetalter_url(Assetalter.last)
  end

  test "should show assetalter" do
    get assetalter_url(@assetalter)
    assert_response :success
  end

  test "should get edit" do
    get edit_assetalter_url(@assetalter)
    assert_response :success
  end

  test "should update assetalter" do
    patch assetalter_url(@assetalter), params: { assetalter: { Alterdate: @assetalter.Alterdate, Code: @assetalter.Code, Fbillno: @assetalter.Fbillno, Reason: @assetalter.Reason, name: @assetalter.name } }
    assert_redirected_to assetalter_url(@assetalter)
  end

  test "should destroy assetalter" do
    assert_difference('Assetalter.count', -1) do
      delete assetalter_url(@assetalter)
    end

    assert_redirected_to assetalters_url
  end
end
