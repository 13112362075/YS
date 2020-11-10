class CreateAssetcards < ActiveRecord::Migration[6.0]
  def change
    create_table :assetcards do |t|
      t.string :assetCode
      t.string :assetname
      t.integer :Assettype_id
      t.integer :Unit_id
      t.integer :Amount
      t.integer :Assetstatus_id
      t.integer :Addtype_id
      t.date :BuyDate
      t.integer :Usestate_id
      t.string :description
      t.integer :Orgainize_id
      t.date :Entrydate
      t.decimal :Price
      t.decimal :Lastprice
      t.integer :Expectedperiod
      t.integer :CNOSP
      t.string :barcode
      t.string :Mould
      t.integer :Assetseat_id
      t.string :Client
      t.string :Supplier
      t.integer :department_id
      t.integer :Employeeld

      t.timestamps
    end
  end
end
