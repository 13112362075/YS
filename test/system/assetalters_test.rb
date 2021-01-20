require "application_system_test_case"

class AssetaltersTest < ApplicationSystemTestCase
  setup do
    @assetalter = assetalters(:one)
  end

  test "visiting the index" do
    visit assetalters_url
    assert_selector "h1", text: "Assetalters"
  end

  test "creating a Assetalter" do
    visit assetalters_url
    click_on "New Assetalter"

    fill_in "Addtype", with: @assetalter.Addtype_id
    fill_in "Addtype id old", with: @assetalter.Addtype_id_Old
    fill_in "Amount", with: @assetalter.Amount
    fill_in "Amount old", with: @assetalter.Amount_Old
    fill_in "Approver", with: @assetalter.Approver
    fill_in "Approverdate", with: @assetalter.Approverdate
    fill_in "Assetseat", with: @assetalter.Assetseat_id
    fill_in "Assetseat id old", with: @assetalter.Assetseat_id_Old
    fill_in "Assetstatus", with: @assetalter.Assetstatus_id
    fill_in "Assetstatus id old", with: @assetalter.Assetstatus_id_Old
    fill_in "Assettype", with: @assetalter.Assettype_id
    fill_in "Assettype id old", with: @assetalter.Assettype_id_Old
    fill_in "Buydate", with: @assetalter.BuyDate
    fill_in "Buydate old", with: @assetalter.BuyDate_Old
    fill_in "Cnosp", with: @assetalter.CNOSP
    fill_in "Cnosp old", with: @assetalter.CNOSP_Old
    fill_in "Client", with: @assetalter.Client
    fill_in "Client old", with: @assetalter.Client_Old
    fill_in "Createdate", with: @assetalter.Createdate
    fill_in "Creator", with: @assetalter.Creator
    fill_in "Employeeld", with: @assetalter.Employeeld
    fill_in "Employeeld old", with: @assetalter.Employeeld_Old
    fill_in "Entrydate", with: @assetalter.Entrydate
    fill_in "Entrydate old", with: @assetalter.Entrydate_Old
    fill_in "Expectedperiod", with: @assetalter.Expectedperiod
    fill_in "Expectedperiod old", with: @assetalter.Expectedperiod_Old
    fill_in "Fbillno", with: @assetalter.Fbillno
    fill_in "Lastprice", with: @assetalter.Lastprice
    fill_in "Lastprice old", with: @assetalter.Lastprice_Old
    fill_in "Mould", with: @assetalter.Mould
    fill_in "Mould old", with: @assetalter.Mould_Old
    fill_in "Orgainize", with: @assetalter.Orgainize_id
    fill_in "Orgainize id old", with: @assetalter.Orgainize_id_Old
    fill_in "Price", with: @assetalter.Price
    fill_in "Price old", with: @assetalter.Price_Old
    fill_in "Supplier", with: @assetalter.Supplier
    fill_in "Supplier old", with: @assetalter.Supplier_Old
    fill_in "Unit", with: @assetalter.Unit_id
    fill_in "Unit id old", with: @assetalter.Unit_id_Old
    fill_in "Assetcode", with: @assetalter.assetCode
    fill_in "Assetcode old", with: @assetalter.assetCode_Old
    fill_in "Assetname", with: @assetalter.assetname
    fill_in "Assetname old", with: @assetalter.assetname_Old
    fill_in "Barcode", with: @assetalter.barcode
    fill_in "Barcode old", with: @assetalter.barcode_Old
    fill_in "Department", with: @assetalter.department_id
    fill_in "Department id old", with: @assetalter.department_id_Old
    fill_in "Description", with: @assetalter.description
    fill_in "Description old", with: @assetalter.description_Old
    fill_in "Fbillstatus", with: @assetalter.fbillstatus
    click_on "Create Assetalter"

    assert_text "Assetalter was successfully created"
    click_on "Back"
  end

  test "updating a Assetalter" do
    visit assetalters_url
    click_on "Edit", match: :first

    fill_in "Addtype", with: @assetalter.Addtype_id
    fill_in "Addtype id old", with: @assetalter.Addtype_id_Old
    fill_in "Amount", with: @assetalter.Amount
    fill_in "Amount old", with: @assetalter.Amount_Old
    fill_in "Approver", with: @assetalter.Approver
    fill_in "Approverdate", with: @assetalter.Approverdate
    fill_in "Assetseat", with: @assetalter.Assetseat_id
    fill_in "Assetseat id old", with: @assetalter.Assetseat_id_Old
    fill_in "Assetstatus", with: @assetalter.Assetstatus_id
    fill_in "Assetstatus id old", with: @assetalter.Assetstatus_id_Old
    fill_in "Assettype", with: @assetalter.Assettype_id
    fill_in "Assettype id old", with: @assetalter.Assettype_id_Old
    fill_in "Buydate", with: @assetalter.BuyDate
    fill_in "Buydate old", with: @assetalter.BuyDate_Old
    fill_in "Cnosp", with: @assetalter.CNOSP
    fill_in "Cnosp old", with: @assetalter.CNOSP_Old
    fill_in "Client", with: @assetalter.Client
    fill_in "Client old", with: @assetalter.Client_Old
    fill_in "Createdate", with: @assetalter.Createdate
    fill_in "Creator", with: @assetalter.Creator
    fill_in "Employeeld", with: @assetalter.Employeeld
    fill_in "Employeeld old", with: @assetalter.Employeeld_Old
    fill_in "Entrydate", with: @assetalter.Entrydate
    fill_in "Entrydate old", with: @assetalter.Entrydate_Old
    fill_in "Expectedperiod", with: @assetalter.Expectedperiod
    fill_in "Expectedperiod old", with: @assetalter.Expectedperiod_Old
    fill_in "Fbillno", with: @assetalter.Fbillno
    fill_in "Lastprice", with: @assetalter.Lastprice
    fill_in "Lastprice old", with: @assetalter.Lastprice_Old
    fill_in "Mould", with: @assetalter.Mould
    fill_in "Mould old", with: @assetalter.Mould_Old
    fill_in "Orgainize", with: @assetalter.Orgainize_id
    fill_in "Orgainize id old", with: @assetalter.Orgainize_id_Old
    fill_in "Price", with: @assetalter.Price
    fill_in "Price old", with: @assetalter.Price_Old
    fill_in "Supplier", with: @assetalter.Supplier
    fill_in "Supplier old", with: @assetalter.Supplier_Old
    fill_in "Unit", with: @assetalter.Unit_id
    fill_in "Unit id old", with: @assetalter.Unit_id_Old
    fill_in "Assetcode", with: @assetalter.assetCode
    fill_in "Assetcode old", with: @assetalter.assetCode_Old
    fill_in "Assetname", with: @assetalter.assetname
    fill_in "Assetname old", with: @assetalter.assetname_Old
    fill_in "Barcode", with: @assetalter.barcode
    fill_in "Barcode old", with: @assetalter.barcode_Old
    fill_in "Department", with: @assetalter.department_id
    fill_in "Department id old", with: @assetalter.department_id_Old
    fill_in "Description", with: @assetalter.description
    fill_in "Description old", with: @assetalter.description_Old
    fill_in "Fbillstatus", with: @assetalter.fbillstatus
    click_on "Update Assetalter"

    assert_text "Assetalter was successfully updated"
    click_on "Back"
  end

  test "destroying a Assetalter" do
    visit assetalters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Assetalter was successfully destroyed"
  end
end
