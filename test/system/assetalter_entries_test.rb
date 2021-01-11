require "application_system_test_case"

class AssetalterEntriesTest < ApplicationSystemTestCase
  setup do
    @assetalter_entry = assetalter_entries(:one)
  end

  test "visiting the index" do
    visit assetalter_entries_url
    assert_selector "h1", text: "Assetalter Entries"
  end

  test "creating a Assetalter entry" do
    visit assetalter_entries_url
    click_on "New Assetalter Entry"

    fill_in "Altertype", with: @assetalter_entry.Altertype
    fill_in "Assetalter", with: @assetalter_entry.Assetalter_id
    fill_in "Information new", with: @assetalter_entry.Information_New
    fill_in "Information old", with: @assetalter_entry.Information_Old
    click_on "Create Assetalter entry"

    assert_text "Assetalter entry was successfully created"
    click_on "Back"
  end

  test "updating a Assetalter entry" do
    visit assetalter_entries_url
    click_on "Edit", match: :first

    fill_in "Altertype", with: @assetalter_entry.Altertype
    fill_in "Assetalter", with: @assetalter_entry.Assetalter_id
    fill_in "Information new", with: @assetalter_entry.Information_New
    fill_in "Information old", with: @assetalter_entry.Information_Old
    click_on "Update Assetalter entry"

    assert_text "Assetalter entry was successfully updated"
    click_on "Back"
  end

  test "destroying a Assetalter entry" do
    visit assetalter_entries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Assetalter entry was successfully destroyed"
  end
end
