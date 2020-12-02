require "application_system_test_case"

class AssetTurnoverDetailEntriesTest < ApplicationSystemTestCase
  setup do
    @asset_turnover_detail_entry = asset_turnover_detail_entries(:one)
  end

  test "visiting the index" do
    visit asset_turnover_detail_entries_url
    assert_selector "h1", text: "Asset Turnover Detail Entries"
  end

  test "creating a Asset turnover detail entry" do
    visit asset_turnover_detail_entries_url
    click_on "New Asset Turnover Detail Entry"

    fill_in "Amount", with: @asset_turnover_detail_entry.Amount
    fill_in "Assetturnoverdetail", with: @asset_turnover_detail_entry.AssetTurnoverDetail_id
    fill_in "Asset seat", with: @asset_turnover_detail_entry.Asset_seat
    fill_in "Deptment", with: @asset_turnover_detail_entry.Deptment
    fill_in "Employeeld", with: @asset_turnover_detail_entry.Employeeld
    fill_in "Has been returned", with: @asset_turnover_detail_entry.Has_Been_returned
    fill_in "Last seat", with: @asset_turnover_detail_entry.Last_seat
    fill_in "Reasons for borrowing", with: @asset_turnover_detail_entry.Reasons_for_borrowing
    fill_in "Unit", with: @asset_turnover_detail_entry.Unit
    fill_in "Assetcards code", with: @asset_turnover_detail_entry.assetcards_Code
    fill_in "Assetcards name", with: @asset_turnover_detail_entry.assetcards_name
    fill_in "Givebackdate", with: @asset_turnover_detail_entry.givebackDate
    fill_in "Givebackplandate", with: @asset_turnover_detail_entry.givebackPlanDate
    click_on "Create Asset turnover detail entry"

    assert_text "Asset turnover detail entry was successfully created"
    click_on "Back"
  end

  test "updating a Asset turnover detail entry" do
    visit asset_turnover_detail_entries_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @asset_turnover_detail_entry.Amount
    fill_in "Assetturnoverdetail", with: @asset_turnover_detail_entry.AssetTurnoverDetail_id
    fill_in "Asset seat", with: @asset_turnover_detail_entry.Asset_seat
    fill_in "Deptment", with: @asset_turnover_detail_entry.Deptment
    fill_in "Employeeld", with: @asset_turnover_detail_entry.Employeeld
    fill_in "Has been returned", with: @asset_turnover_detail_entry.Has_Been_returned
    fill_in "Last seat", with: @asset_turnover_detail_entry.Last_seat
    fill_in "Reasons for borrowing", with: @asset_turnover_detail_entry.Reasons_for_borrowing
    fill_in "Unit", with: @asset_turnover_detail_entry.Unit
    fill_in "Assetcards code", with: @asset_turnover_detail_entry.assetcards_Code
    fill_in "Assetcards name", with: @asset_turnover_detail_entry.assetcards_name
    fill_in "Givebackdate", with: @asset_turnover_detail_entry.givebackDate
    fill_in "Givebackplandate", with: @asset_turnover_detail_entry.givebackPlanDate
    click_on "Update Asset turnover detail entry"

    assert_text "Asset turnover detail entry was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset turnover detail entry" do
    visit asset_turnover_detail_entries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset turnover detail entry was successfully destroyed"
  end
end
