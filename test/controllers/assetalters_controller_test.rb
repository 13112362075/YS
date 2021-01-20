require 'test_helper'

class AssetaltersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assetalter = assetalters(:one)
  end

  test "should get index" do
    get assetalters_url
    assert_response :success
  end

  test "should get new" do
    get new_assetalter_url
    assert_response :success
  end

  test "should create assetalter" do
    assert_difference('Assetalter.count') do
      post assetalters_url, params: { assetalter: { Addtype_id: @assetalter.Addtype_id, Addtype_id_Old: @assetalter.Addtype_id_Old, Amount: @assetalter.Amount, Amount_Old: @assetalter.Amount_Old, Approver: @assetalter.Approver, Approverdate: @assetalter.Approverdate, Assetseat_id: @assetalter.Assetseat_id, Assetseat_id_Old: @assetalter.Assetseat_id_Old, Assetstatus_id: @assetalter.Assetstatus_id, Assetstatus_id_Old: @assetalter.Assetstatus_id_Old, Assettype_id: @assetalter.Assettype_id, Assettype_id_Old: @assetalter.Assettype_id_Old, BuyDate: @assetalter.BuyDate, BuyDate_Old: @assetalter.BuyDate_Old, CNOSP: @assetalter.CNOSP, CNOSP_Old: @assetalter.CNOSP_Old, Client: @assetalter.Client, Client_Old: @assetalter.Client_Old, Createdate: @assetalter.Createdate, Creator: @assetalter.Creator, Employeeld: @assetalter.Employeeld, Employeeld_Old: @assetalter.Employeeld_Old, Entrydate: @assetalter.Entrydate, Entrydate_Old: @assetalter.Entrydate_Old, Expectedperiod: @assetalter.Expectedperiod, Expectedperiod_Old: @assetalter.Expectedperiod_Old, Fbillno: @assetalter.Fbillno, Lastprice: @assetalter.Lastprice, Lastprice_Old: @assetalter.Lastprice_Old, Mould: @assetalter.Mould, Mould_Old: @assetalter.Mould_Old, Orgainize_id: @assetalter.Orgainize_id, Orgainize_id_Old: @assetalter.Orgainize_id_Old, Price: @assetalter.Price, Price_Old: @assetalter.Price_Old, Supplier: @assetalter.Supplier, Supplier_Old: @assetalter.Supplier_Old, Unit_id: @assetalter.Unit_id, Unit_id_Old: @assetalter.Unit_id_Old, assetCode: @assetalter.assetCode, assetCode_Old: @assetalter.assetCode_Old, assetname: @assetalter.assetname, assetname_Old: @assetalter.assetname_Old, barcode: @assetalter.barcode, barcode_Old: @assetalter.barcode_Old, department_id: @assetalter.department_id, department_id_Old: @assetalter.department_id_Old, description: @assetalter.description, description_Old: @assetalter.description_Old, fbillstatus: @assetalter.fbillstatus } }
    end

    assert_redirected_to assetalter_url(Assetalter.last)
  end

  test "should show assetalter" do
    get assetalter_url(@assetalter)
    assert_response :success
  end

  test "should get edit" do
    get edit_assetalter_url(@assetalter)
    assert_response :success
  end

  test "should update assetalter" do
    patch assetalter_url(@assetalter), params: { assetalter: { Addtype_id: @assetalter.Addtype_id, Addtype_id_Old: @assetalter.Addtype_id_Old, Amount: @assetalter.Amount, Amount_Old: @assetalter.Amount_Old, Approver: @assetalter.Approver, Approverdate: @assetalter.Approverdate, Assetseat_id: @assetalter.Assetseat_id, Assetseat_id_Old: @assetalter.Assetseat_id_Old, Assetstatus_id: @assetalter.Assetstatus_id, Assetstatus_id_Old: @assetalter.Assetstatus_id_Old, Assettype_id: @assetalter.Assettype_id, Assettype_id_Old: @assetalter.Assettype_id_Old, BuyDate: @assetalter.BuyDate, BuyDate_Old: @assetalter.BuyDate_Old, CNOSP: @assetalter.CNOSP, CNOSP_Old: @assetalter.CNOSP_Old, Client: @assetalter.Client, Client_Old: @assetalter.Client_Old, Createdate: @assetalter.Createdate, Creator: @assetalter.Creator, Employeeld: @assetalter.Employeeld, Employeeld_Old: @assetalter.Employeeld_Old, Entrydate: @assetalter.Entrydate, Entrydate_Old: @assetalter.Entrydate_Old, Expectedperiod: @assetalter.Expectedperiod, Expectedperiod_Old: @assetalter.Expectedperiod_Old, Fbillno: @assetalter.Fbillno, Lastprice: @assetalter.Lastprice, Lastprice_Old: @assetalter.Lastprice_Old, Mould: @assetalter.Mould, Mould_Old: @assetalter.Mould_Old, Orgainize_id: @assetalter.Orgainize_id, Orgainize_id_Old: @assetalter.Orgainize_id_Old, Price: @assetalter.Price, Price_Old: @assetalter.Price_Old, Supplier: @assetalter.Supplier, Supplier_Old: @assetalter.Supplier_Old, Unit_id: @assetalter.Unit_id, Unit_id_Old: @assetalter.Unit_id_Old, assetCode: @assetalter.assetCode, assetCode_Old: @assetalter.assetCode_Old, assetname: @assetalter.assetname, assetname_Old: @assetalter.assetname_Old, barcode: @assetalter.barcode, barcode_Old: @assetalter.barcode_Old, department_id: @assetalter.department_id, department_id_Old: @assetalter.department_id_Old, description: @assetalter.description, description_Old: @assetalter.description_Old, fbillstatus: @assetalter.fbillstatus } }
    assert_redirected_to assetalter_url(@assetalter)
  end

  test "should destroy assetalter" do
    assert_difference('Assetalter.count', -1) do
      delete assetalter_url(@assetalter)
    end

    assert_redirected_to assetalters_url
  end
end
