class CreateAssetGainEntries < ActiveRecord::Migration[6.0]
  def change 
    create_table :asset_gain_entries do |t|
      t.string :Code
      t.string :name
      t.string :Asset_type
      t.string :Unit
      t.decimal :BookQty
      t.decimal :CountQty
      t.decimal :GainQty
      t.string :Book_seat
      t.string :Book_dept
      t.string :Book_User
      t.string :Actual_seat
      t.string :Actual_dept
      t.string :Actual_User
      t.string :fseq
      t.string :Asset_Gain_id
      t.string :FSrcFbillno
      t.string :FSrcFseq

      t.timestamps
    end
  end
end
