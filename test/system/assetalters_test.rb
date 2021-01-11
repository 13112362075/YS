require "application_system_test_case"

class AssetaltersTest < ApplicationSystemTestCase
  setup do
    @assetalter = assetalters(:one)
  end

  test "visiting the index" do
    visit assetalters_url
    assert_selector "h1", text: "Assetalters"
  end

  test "creating a Assetalter" do
    visit assetalters_url
    click_on "New Assetalter"

    fill_in "Alterdate", with: @assetalter.Alterdate
    fill_in "Code", with: @assetalter.Code
    fill_in "Fbillno", with: @assetalter.Fbillno
    fill_in "Reason", with: @assetalter.Reason
    fill_in "Name", with: @assetalter.name
    click_on "Create Assetalter"

    assert_text "Assetalter was successfully created"
    click_on "Back"
  end

  test "updating a Assetalter" do
    visit assetalters_url
    click_on "Edit", match: :first

    fill_in "Alterdate", with: @assetalter.Alterdate
    fill_in "Code", with: @assetalter.Code
    fill_in "Fbillno", with: @assetalter.Fbillno
    fill_in "Reason", with: @assetalter.Reason
    fill_in "Name", with: @assetalter.name
    click_on "Update Assetalter"

    assert_text "Assetalter was successfully updated"
    click_on "Back"
  end

  test "destroying a Assetalter" do
    visit assetalters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Assetalter was successfully destroyed"
  end
end
