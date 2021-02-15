class CreateAssetCountingreportEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :asset_countingreport_entries do |t|
      t.string :Code
      t.string :name
      t.string :Asset_type
      t.string :Unit
      t.string :Model
      t.string :Asset_status
      t.decimal :BookQty
      t.decimal :CountQty
      t.decimal :Variance
      t.string :Book_seat
      t.string :Book_dept
      t.string :Book_User
      t.string :Invent_seat
      t.string :Invent_dept
      t.string :InventUser
      t.datetime :CountDate
      t.string :Headnote
      t.string :fseq
      t.string :Asset_Countingreport_id

      t.timestamps
    end
  end
end
