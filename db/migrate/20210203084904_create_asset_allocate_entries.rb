class CreateAssetAllocateEntries < ActiveRecord::Migration[6.0]
  def change
    drop_table :asset_allocate_entries
    create_table :asset_allocate_entries do |t|
      t.string :Code
      t.string :name
      t.string :Unit
      t.string :Model
      t.decimal :Amount
      t.string :EXPdept
      t.string :Employeeld
      t.string :Asset_seat
      t.decimal :EXPQTY
      t.string :IMPdept
      t.string :Newuser
      t.string :IMP_seat
      t.string :fseq
      t.string :Asset_allocate_id

      t.timestamps
    end
  end
end
