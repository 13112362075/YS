require "application_system_test_case"

class UsestatesTest < ApplicationSystemTestCase
  setup do
    @usestate = usestates(:one)
  end

  test "visiting the index" do
    visit usestates_url
    assert_selector "h1", text: "Usestates"
  end

  test "creating a Usestate" do
    visit usestates_url
    click_on "New Usestate"

    fill_in "Description", with: @usestate.Description
    fill_in "Name", with: @usestate.Name
    fill_in "Orgainize", with: @usestate.Orgainize_id
    fill_in "Usestatecode", with: @usestate.Usestatecode
    click_on "Create Usestate"

    assert_text "Usestate was successfully created"
    click_on "Back"
  end

  test "updating a Usestate" do
    visit usestates_url
    click_on "Edit", match: :first

    fill_in "Description", with: @usestate.Description
    fill_in "Name", with: @usestate.Name
    fill_in "Orgainize", with: @usestate.Orgainize_id
    fill_in "Usestatecode", with: @usestate.Usestatecode
    click_on "Update Usestate"

    assert_text "Usestate was successfully updated"
    click_on "Back"
  end

  test "destroying a Usestate" do
    visit usestates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Usestate was successfully destroyed"
  end
end
