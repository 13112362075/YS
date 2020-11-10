require 'test_helper'

class AssetcardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assetcard = assetcards(:one)
  end

  test "should get index" do
    get assetcards_url
    assert_response :success
  end

  test "should get new" do
    get new_assetcard_url
    assert_response :success
  end

  test "should create assetcard" do
    assert_difference('Assetcard.count') do
      post assetcards_url, params: { assetcard: { Addtype_id: @assetcard.Addtype_id, Amount: @assetcard.Amount, Assetseat_id: @assetcard.Assetseat_id, Assetstatus_id: @assetcard.Assetstatus_id, Assettype_id: @assetcard.Assettype_id, BuyDate: @assetcard.BuyDate, CNOSP: @assetcard.CNOSP, Client: @assetcard.Client, Employeeld: @assetcard.Employeeld, Entrydate: @assetcard.Entrydate, Expectedperiod: @assetcard.Expectedperiod, Lastprice: @assetcard.Lastprice, Mould: @assetcard.Mould, Orgainize_id: @assetcard.Orgainize_id, Price: @assetcard.Price, Supplier: @assetcard.Supplier, Unit_id: @assetcard.Unit_id, Usestate_id: @assetcard.Usestate_id, assetCode: @assetcard.assetCode, assetname: @assetcard.assetname, barcode: @assetcard.barcode, department_id: @assetcard.department_id, description: @assetcard.description } }
    end

    assert_redirected_to assetcard_url(Assetcard.last)
  end

  test "should show assetcard" do
    get assetcard_url(@assetcard)
    assert_response :success
  end

  test "should get edit" do
    get edit_assetcard_url(@assetcard)
    assert_response :success
  end

  test "should update assetcard" do
    patch assetcard_url(@assetcard), params: { assetcard: { Addtype_id: @assetcard.Addtype_id, Amount: @assetcard.Amount, Assetseat_id: @assetcard.Assetseat_id, Assetstatus_id: @assetcard.Assetstatus_id, Assettype_id: @assetcard.Assettype_id, BuyDate: @assetcard.BuyDate, CNOSP: @assetcard.CNOSP, Client: @assetcard.Client, Employeeld: @assetcard.Employeeld, Entrydate: @assetcard.Entrydate, Expectedperiod: @assetcard.Expectedperiod, Lastprice: @assetcard.Lastprice, Mould: @assetcard.Mould, Orgainize_id: @assetcard.Orgainize_id, Price: @assetcard.Price, Supplier: @assetcard.Supplier, Unit_id: @assetcard.Unit_id, Usestate_id: @assetcard.Usestate_id, assetCode: @assetcard.assetCode, assetname: @assetcard.assetname, barcode: @assetcard.barcode, department_id: @assetcard.department_id, description: @assetcard.description } }
    assert_redirected_to assetcard_url(@assetcard)
  end

  test "should destroy assetcard" do
    assert_difference('Assetcard.count', -1) do
      delete assetcard_url(@assetcard)
    end

    assert_redirected_to assetcards_url
  end
end
