require 'test_helper'

class AssetalterEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assetalter_entry = assetalter_entries(:one)
  end

  test "should get index" do
    get assetalter_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_assetalter_entry_url
    assert_response :success
  end

  test "should create assetalter_entry" do
    assert_difference('AssetalterEntry.count') do
      post assetalter_entries_url, params: { assetalter_entry: { Altertype: @assetalter_entry.Altertype, Assetalter_id: @assetalter_entry.Assetalter_id, Information_New: @assetalter_entry.Information_New, Information_Old: @assetalter_entry.Information_Old } }
    end

    assert_redirected_to assetalter_entry_url(AssetalterEntry.last)
  end

  test "should show assetalter_entry" do
    get assetalter_entry_url(@assetalter_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_assetalter_entry_url(@assetalter_entry)
    assert_response :success
  end

  test "should update assetalter_entry" do
    patch assetalter_entry_url(@assetalter_entry), params: { assetalter_entry: { Altertype: @assetalter_entry.Altertype, Assetalter_id: @assetalter_entry.Assetalter_id, Information_New: @assetalter_entry.Information_New, Information_Old: @assetalter_entry.Information_Old } }
    assert_redirected_to assetalter_entry_url(@assetalter_entry)
  end

  test "should destroy assetalter_entry" do
    assert_difference('AssetalterEntry.count', -1) do
      delete assetalter_entry_url(@assetalter_entry)
    end

    assert_redirected_to assetalter_entries_url
  end
end
