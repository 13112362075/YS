require "application_system_test_case"

class AddtypesTest < ApplicationSystemTestCase
  setup do
    @addtype = addtypes(:one)
  end

  test "visiting the index" do
    visit addtypes_url
    assert_selector "h1", text: "Addtypes"
  end

  test "creating a Addtype" do
    visit addtypes_url
    click_on "New Addtype"

    fill_in "Addtypecode", with: @addtype.Addtypecode
    fill_in "Description", with: @addtype.Description
    fill_in "Name", with: @addtype.Name
    fill_in "Orgainize", with: @addtype.Orgainize_id
    click_on "Create Addtype"

    assert_text "Addtype was successfully created"
    click_on "Back"
  end

  test "updating a Addtype" do
    visit addtypes_url
    click_on "Edit", match: :first

    fill_in "Addtypecode", with: @addtype.Addtypecode
    fill_in "Description", with: @addtype.Description
    fill_in "Name", with: @addtype.Name
    fill_in "Orgainize", with: @addtype.Orgainize_id
    click_on "Update Addtype"

    assert_text "Addtype was successfully updated"
    click_on "Back"
  end

  test "destroying a Addtype" do
    visit addtypes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Addtype was successfully destroyed"
  end
end
