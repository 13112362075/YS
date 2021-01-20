class CreateAssetalters < ActiveRecord::Migration[6.0]
  def change
    drop_table :assetalters
    create_table :assetalters do |t|
      t.string :Fbillno
      t.string :assetCode
      t.string :assetname
      t.string :Assettype_id
      t.string :Unit_id
      t.integer :Amount
      t.string :Assetstatus_id
      t.string :Addtype_id
      t.datetime :BuyDate
      t.string :description
      t.string :Orgainize_id
      t.datetime :Entrydate
      t.decimal :Price
      t.decimal :Lastprice
      t.integer :Expectedperiod
      t.string :CNOSP
      t.string :barcode
      t.string :Mould
      t.string :Assetseat_id
      t.string :Client
      t.string :Supplier
      t.string :department_id
      t.string :Employeeld
      t.string :assetCode_Old
      t.string :assetname_Old
      t.string :Assettype_id_Old
      t.string :Unit_id_Old
      t.integer :Amount_Old
      t.string :Assetstatus_id_Old
      t.string :Addtype_id_Old
      t.datetime :BuyDate_Old
      t.string :description_Old
      t.string :Orgainize_id_Old
      t.datetime :Entrydate_Old
      t.decimal :Price_Old
      t.decimal :Lastprice_Old
      t.integer :Expectedperiod_Old
      t.string :CNOSP_Old
      t.string :barcode_Old
      t.string :Mould_Old
      t.string :Assetseat_id_Old
      t.string :Client_Old
      t.string :Supplier_Old
      t.string :department_id_Old
      t.string :Employeeld_Old
      t.string :fbillstatus
      t.string :Creator
      t.datetime :Createdate
      t.string :Approver
      t.datetime :Approverdate

      t.timestamps
    end
  end
end
