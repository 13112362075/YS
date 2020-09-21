require "application_system_test_case"

class AssettypesTest < ApplicationSystemTestCase
  setup do
    @assettype = assettypes(:one)
  end

  test "visiting the index" do
    visit assettypes_url
    assert_selector "h1", text: "Assettypes"
  end

  test "creating a Assettype" do
    visit assettypes_url
    click_on "New Assettype"

    fill_in "Assettypecode", with: @assettype.Assettypecode
    fill_in "Name", with: @assettype.Name
    fill_in "Orgainize", with: @assettype.Orgainize_id
    fill_in "Description", with: @assettype.description
    click_on "Create Assettype"

    assert_text "Assettype was successfully created"
    click_on "Back"
  end

  test "updating a Assettype" do
    visit assettypes_url
    click_on "Edit", match: :first

    fill_in "Assettypecode", with: @assettype.Assettypecode
    fill_in "Name", with: @assettype.Name
    fill_in "Orgainize", with: @assettype.Orgainize_id
    fill_in "Description", with: @assettype.description
    click_on "Update Assettype"

    assert_text "Assettype was successfully updated"
    click_on "Back"
  end

  test "destroying a Assettype" do
    visit assettypes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Assettype was successfully destroyed"
  end
end
