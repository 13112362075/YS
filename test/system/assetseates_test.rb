require "application_system_test_case"

class AssetseatesTest < ApplicationSystemTestCase
  setup do
    @assetseate = assetseates(:one)
  end

  test "visiting the index" do
    visit assetseates_url
    assert_selector "h1", text: "Assetseates"
  end

  test "creating a Assetseate" do
    visit assetseates_url
    click_on "New Assetseate"

    fill_in "Assetseatecode", with: @assetseate.Assetseatecode
    fill_in "Description", with: @assetseate.Description
    fill_in "Name", with: @assetseate.Name
    fill_in "Orgainize", with: @assetseate.Orgainize_id
    click_on "Create Assetseate"

    assert_text "Assetseate was successfully created"
    click_on "Back"
  end

  test "updating a Assetseate" do
    visit assetseates_url
    click_on "Edit", match: :first

    fill_in "Assetseatecode", with: @assetseate.Assetseatecode
    fill_in "Description", with: @assetseate.Description
    fill_in "Name", with: @assetseate.Name
    fill_in "Orgainize", with: @assetseate.Orgainize_id
    click_on "Update Assetseate"

    assert_text "Assetseate was successfully updated"
    click_on "Back"
  end

  test "destroying a Assetseate" do
    visit assetseates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Assetseate was successfully destroyed"
  end
end
