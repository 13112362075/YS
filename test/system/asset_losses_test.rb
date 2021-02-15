require "application_system_test_case"

class AssetLossesTest < ApplicationSystemTestCase
  setup do
    @asset_loss = asset_losses(:one)
  end

  test "visiting the index" do
    visit asset_losses_url
    assert_selector "h1", text: "Asset Losses"
  end

  test "creating a Asset loss" do
    visit asset_losses_url
    click_on "New Asset Loss"

    fill_in "Approvedate", with: @asset_loss.APPROVEDATE
    fill_in "Approver", with: @asset_loss.Approver
    fill_in "Billno", with: @asset_loss.BillNo
    fill_in "Createdate", with: @asset_loss.CREATEDATE
    fill_in "Creator", with: @asset_loss.Creator
    fill_in "Description", with: @asset_loss.description
    fill_in "Fbillstatus", with: @asset_loss.fbillstatus
    fill_in "Fdate", with: @asset_loss.fdate
    click_on "Create Asset loss"

    assert_text "Asset loss was successfully created"
    click_on "Back"
  end

  test "updating a Asset loss" do
    visit asset_losses_url
    click_on "Edit", match: :first

    fill_in "Approvedate", with: @asset_loss.APPROVEDATE
    fill_in "Approver", with: @asset_loss.Approver
    fill_in "Billno", with: @asset_loss.BillNo
    fill_in "Createdate", with: @asset_loss.CREATEDATE
    fill_in "Creator", with: @asset_loss.Creator
    fill_in "Description", with: @asset_loss.description
    fill_in "Fbillstatus", with: @asset_loss.fbillstatus
    fill_in "Fdate", with: @asset_loss.fdate
    click_on "Update Asset loss"

    assert_text "Asset loss was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset loss" do
    visit asset_losses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset loss was successfully destroyed"
  end
end
