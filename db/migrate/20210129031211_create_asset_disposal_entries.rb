class CreateAssetDisposalEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :asset_disposal_entries do |t|
      t.string :Code
      t.string :name
      t.string :Unit
      t.decimal :Amount
      t.decimal :DisposeAmount
      t.string :Asset_seat
      t.decimal :DisposePrice

      t.timestamps
    end
  end
end
