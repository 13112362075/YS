require "application_system_test_case"

class AssetAllocatesTest < ApplicationSystemTestCase
  setup do
    @asset_allocate = asset_allocates(:one)
  end

  test "visiting the index" do
    visit asset_allocates_url
    assert_selector "h1", text: "Asset Allocates"
  end

  test "creating a Asset allocate" do
    visit asset_allocates_url
    click_on "New Asset Allocate"

    fill_in "Allocate reason", with: @asset_allocate.Allocate_reason
    fill_in "Bring in confirm", with: @asset_allocate.Bring_in_Confirm
    fill_in "Bring in number", with: @asset_allocate.Bring_in_Number
    fill_in "Bring in to", with: @asset_allocate.Bring_in_to_id
    fill_in "Document number", with: @asset_allocate.Document_number
    fill_in "Pull up date", with: @asset_allocate.Pull_up_date
    fill_in "Pull up to", with: @asset_allocate.Pull_up_to_id
    click_on "Create Asset allocate"

    assert_text "Asset allocate was successfully created"
    click_on "Back"
  end

  test "updating a Asset allocate" do
    visit asset_allocates_url
    click_on "Edit", match: :first

    fill_in "Allocate reason", with: @asset_allocate.Allocate_reason
    fill_in "Bring in confirm", with: @asset_allocate.Bring_in_Confirm
    fill_in "Bring in number", with: @asset_allocate.Bring_in_Number
    fill_in "Bring in to", with: @asset_allocate.Bring_in_to_id
    fill_in "Document number", with: @asset_allocate.Document_number
    fill_in "Pull up date", with: @asset_allocate.Pull_up_date
    fill_in "Pull up to", with: @asset_allocate.Pull_up_to_id
    click_on "Update Asset allocate"

    assert_text "Asset allocate was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset allocate" do
    visit asset_allocates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset allocate was successfully destroyed"
  end
end
