class CreateAssetRecoveryEntries < ActiveRecord::Migration[6.0]
  def change
    drop_table:asset_recovery_entries
    create_table :asset_recovery_entries do |t|
      t.string :Code
      t.string :name
      t.string :Asset_type
      t.string :Unit
      t.string :Requisition_Amount
      t.integer :Amount_returned
      t.integer :Amount_Returnable
      t.string :Asset_status
      t.string :Requisition_Department
      t.string :Requisition_Employeeld
      t.string :Requisition_use
      t.integer :Asset_recovery_id

      t.timestamps
    end
  end
end
