class CreateAssetAllocateEntries < ActiveRecord::Migration[6.0]
  def change
    drop_table :asset_allocate_entries
    create_table :asset_allocate_entries do |t|
      t.string :Code
      t.string :name
      t.string :Unit
      t.integer :Amount
      t.integer :Transfer_out_quantity
      t.string :Asset_seat
      t.integer :Asset_allocate_id

      t.timestamps
    end
  end
end
