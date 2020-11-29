require "application_system_test_case"

class AssetTurnoverDetailsTest < ApplicationSystemTestCase
  setup do
    @asset_turnover_detail = asset_turnover_details(:one)
  end

  test "visiting the index" do
    visit asset_turnover_details_url
    assert_selector "h1", text: "Asset Turnover Details"
  end

  test "creating a Asset turnover detail" do
    visit asset_turnover_details_url
    click_on "New Asset Turnover Detail"

    fill_in "Borrowed to", with: @asset_turnover_detail.Borrowed_To_id
    fill_in "Borrowing department", with: @asset_turnover_detail.Borrowing_Department
    fill_in "Borrowing date", with: @asset_turnover_detail.Borrowing_date
    fill_in "Document number", with: @asset_turnover_detail.Document_number
    fill_in "Loaner", with: @asset_turnover_detail.Loaner
    click_on "Create Asset turnover detail"

    assert_text "Asset turnover detail was successfully created"
    click_on "Back"
  end

  test "updating a Asset turnover detail" do
    visit asset_turnover_details_url
    click_on "Edit", match: :first

    fill_in "Borrowed to", with: @asset_turnover_detail.Borrowed_To_id
    fill_in "Borrowing department", with: @asset_turnover_detail.Borrowing_Department
    fill_in "Borrowing date", with: @asset_turnover_detail.Borrowing_date
    fill_in "Document number", with: @asset_turnover_detail.Document_number
    fill_in "Loaner", with: @asset_turnover_detail.Loaner
    click_on "Update Asset turnover detail"

    assert_text "Asset turnover detail was successfully updated"
    click_on "Back"
  end

  test "destroying a Asset turnover detail" do
    visit asset_turnover_details_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Asset turnover detail was successfully destroyed"
  end
end
