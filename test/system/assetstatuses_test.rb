require "application_system_test_case"

class AssetstatusesTest < ApplicationSystemTestCase
  setup do
    @assetstatus = assetstatuses(:one)
  end

  test "visiting the index" do
    visit assetstatuses_url
    assert_selector "h1", text: "Assetstatuses"
  end

  test "creating a Assetstatus" do
    visit assetstatuses_url
    click_on "New Assetstatus"

    fill_in "Assetstatuscode", with: @assetstatus.Assetstatuscode
    fill_in "Name", with: @assetstatus.Name
    fill_in "Orgainize", with: @assetstatus.Orgainize_id
    fill_in "Description", with: @assetstatus.description
    click_on "Create Assetstatus"

    assert_text "Assetstatus was successfully created"
    click_on "Back"
  end

  test "updating a Assetstatus" do
    visit assetstatuses_url
    click_on "Edit", match: :first

    fill_in "Assetstatuscode", with: @assetstatus.Assetstatuscode
    fill_in "Name", with: @assetstatus.Name
    fill_in "Orgainize", with: @assetstatus.Orgainize_id
    fill_in "Description", with: @assetstatus.description
    click_on "Update Assetstatus"

    assert_text "Assetstatus was successfully updated"
    click_on "Back"
  end

  test "destroying a Assetstatus" do
    visit assetstatuses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Assetstatus was successfully destroyed"
  end
end
