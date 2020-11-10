require "application_system_test_case"

class AssetcardsTest < ApplicationSystemTestCase
  setup do
    @assetcard = assetcards(:one)
  end

  test "visiting the index" do
    visit assetcards_url
    assert_selector "h1", text: "Assetcards"
  end

  test "creating a Assetcard" do
    visit assetcards_url
    click_on "New Assetcard"

    fill_in "Addtype", with: @assetcard.Addtype_id
    fill_in "Amount", with: @assetcard.Amount
    fill_in "Assetseat", with: @assetcard.Assetseat_id
    fill_in "Assetstatus", with: @assetcard.Assetstatus_id
    fill_in "Assettype", with: @assetcard.Assettype_id
    fill_in "Buydate", with: @assetcard.BuyDate
    fill_in "Cnosp", with: @assetcard.CNOSP
    fill_in "Client", with: @assetcard.Client
    fill_in "Employeeld", with: @assetcard.Employeeld
    fill_in "Entrydate", with: @assetcard.Entrydate
    fill_in "Expectedperiod", with: @assetcard.Expectedperiod
    fill_in "Lastprice", with: @assetcard.Lastprice
    fill_in "Mould", with: @assetcard.Mould
    fill_in "Orgainize", with: @assetcard.Orgainize_id
    fill_in "Price", with: @assetcard.Price
    fill_in "Supplier", with: @assetcard.Supplier
    fill_in "Unit", with: @assetcard.Unit_id
    fill_in "Usestate", with: @assetcard.Usestate_id
    fill_in "Assetcode", with: @assetcard.assetCode
    fill_in "Assetname", with: @assetcard.assetname
    fill_in "Barcode", with: @assetcard.barcode
    fill_in "Department", with: @assetcard.department_id
    fill_in "Description", with: @assetcard.description
    click_on "Create Assetcard"

    assert_text "Assetcard was successfully created"
    click_on "Back"
  end

  test "updating a Assetcard" do
    visit assetcards_url
    click_on "Edit", match: :first

    fill_in "Addtype", with: @assetcard.Addtype_id
    fill_in "Amount", with: @assetcard.Amount
    fill_in "Assetseat", with: @assetcard.Assetseat_id
    fill_in "Assetstatus", with: @assetcard.Assetstatus_id
    fill_in "Assettype", with: @assetcard.Assettype_id
    fill_in "Buydate", with: @assetcard.BuyDate
    fill_in "Cnosp", with: @assetcard.CNOSP
    fill_in "Client", with: @assetcard.Client
    fill_in "Employeeld", with: @assetcard.Employeeld
    fill_in "Entrydate", with: @assetcard.Entrydate
    fill_in "Expectedperiod", with: @assetcard.Expectedperiod
    fill_in "Lastprice", with: @assetcard.Lastprice
    fill_in "Mould", with: @assetcard.Mould
    fill_in "Orgainize", with: @assetcard.Orgainize_id
    fill_in "Price", with: @assetcard.Price
    fill_in "Supplier", with: @assetcard.Supplier
    fill_in "Unit", with: @assetcard.Unit_id
    fill_in "Usestate", with: @assetcard.Usestate_id
    fill_in "Assetcode", with: @assetcard.assetCode
    fill_in "Assetname", with: @assetcard.assetname
    fill_in "Barcode", with: @assetcard.barcode
    fill_in "Department", with: @assetcard.department_id
    fill_in "Description", with: @assetcard.description
    click_on "Update Assetcard"

    assert_text "Assetcard was successfully updated"
    click_on "Back"
  end

  test "destroying a Assetcard" do
    visit assetcards_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Assetcard was successfully destroyed"
  end
end
