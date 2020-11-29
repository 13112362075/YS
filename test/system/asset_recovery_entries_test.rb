require "application_system_test_case"

class AssetRecoveryEntriesTest < ApplicationSystemTestCase
  setup do
    @asset_recovery_entry = asset_recovery_entries(:one)
  end

  test "visiting the index" do
    visit asset_recovery_entries_url
    assert_selector "h1", text: "Asset Recovery Entries"
  end

  test "creating a Asset recovery entry" do
    visit asset_recovery_entries_url
    click_on "New Asset Recovery Entry"

    fill_in "Amount returnable", with: @asset_recovery_entry.Amount_Returnable
    fill_in "Amount returned", with: @asset_recovery_entry.Amount_returned
    fill_in "Asset status", with: @asset_recovery_entry.Asset_status
    fill_in "Asset type", with: @asset_recovery_entry.Asset_type
    fill_in "Code", with: @asset_recovery_entry.Code
    fill_in "Requisition amount", with: @asset_recovery_entry.Requisition_Amount
    fill_in "Requisition department", with: @asset_recovery_entry.Requisition_Department
    fill_in "Requisition employeeld", with: @asset_recovery_entry.Requisition_Employeeld
    fill_in "Requisition use", with: @asset_recovery_entry.Requisition_use
    fill_in "Unit", with: @asset_recovery_entry.Unit
    fill_in "Name", with: @asset_recovery_entry.name
    click_on "Create Asset recovery entry"

    assert_text "Asset recovery entry was successfully created"
    click_on "Back"
  end

  test "updating a Asset recovery entry" do
    visit asset_recovery_entries_url
    click_on "Edit", match: :first

    fill_in "Amount returnable", with: @asset_recovery_entry.Amount_Returnable
    fill_in "Amount returned", with: @asset_recovery_entry.Amount_returned
    fill_in "Asset status", with: @asset_recovery_entry.Asset_status
    fill_in "Asset type", with: @asset_recovery_entry.Asset_type
    fill_in "Code", with: @asset_recovery_entry.Code
    fill_in "Requisition amount", with: @asset_recovery_entry.Requisition_Amount
    fill_in "Requisition department", with: @asset_recovery_entry.Requisition_Department
    fill_in "Requisition employeeld", with: @asset_recovery_entry.Requisition_Employeeld
    fill_in "Requisition use", with: @asset_recovery_entry.Requisition_use
    fill_in "Unit", with: @asset_recovery_entry.Unit
    fill_in "Name", with: @asset_recovery_entry.name
    click_on "Update Asset recovery entry"

    assert_text "Asset recovery entry was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset recovery entry" do
    visit asset_recovery_entries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset recovery entry was successfully destroyed"
  end
end
