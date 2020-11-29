class CreateAssetAllocateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :asset_allocate_entries do |t|
      t.string :Code
      t.string :name
      t.string :Unit
      t.integer :Amount
      t.string :Transfer
      t.string :out
      t.integer :quantity
      t.string :Asset_seat

      t.timestamps
    end
  end
end
