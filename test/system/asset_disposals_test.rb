require "application_system_test_case"

class AssetDisposalsTest < ApplicationSystemTestCase
  setup do
    @asset_disposal = asset_disposals(:one)
  end

  test "visiting the index" do
    visit asset_disposals_url
    assert_selector "h1", text: "Asset Disposals"
  end

  test "creating a Asset disposal" do
    visit asset_disposals_url
    click_on "New Asset Disposal"

    fill_in "Approvedate", with: @asset_disposal.ApproveDate
    fill_in "Approver", with: @asset_disposal.Approver
    fill_in "Createdate", with: @asset_disposal.CreateDate
    fill_in "Creator", with: @asset_disposal.Creator
    fill_in "Disposedate", with: @asset_disposal.DisposeDate
    fill_in "Disposereason", with: @asset_disposal.DisposeReason
    fill_in "Disposemethod", with: @asset_disposal.Disposemethod
    fill_in "Fbillno", with: @asset_disposal.FBillno
    fill_in "Fbillstatus", with: @asset_disposal.Fbillstatus
    click_on "Create Asset disposal"

    assert_text "Asset disposal was successfully created"
    click_on "Back"
  end

  test "updating a Asset disposal" do
    visit asset_disposals_url
    click_on "Edit", match: :first

    fill_in "Approvedate", with: @asset_disposal.ApproveDate
    fill_in "Approver", with: @asset_disposal.Approver
    fill_in "Createdate", with: @asset_disposal.CreateDate
    fill_in "Creator", with: @asset_disposal.Creator
    fill_in "Disposedate", with: @asset_disposal.DisposeDate
    fill_in "Disposereason", with: @asset_disposal.DisposeReason
    fill_in "Disposemethod", with: @asset_disposal.Disposemethod
    fill_in "Fbillno", with: @asset_disposal.FBillno
    fill_in "Fbillstatus", with: @asset_disposal.Fbillstatus
    click_on "Update Asset disposal"

    assert_text "Asset disposal was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset disposal" do
    visit asset_disposals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset disposal was successfully destroyed"
  end
end
