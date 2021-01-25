class CreateAssetPickingEntries < ActiveRecord::Migration[6.0]
  def change
    drop_table :asset_picking_entries
    create_table :asset_picking_entries do |t|
      t.string :Code
      t.string :name
      t.string :Asset_type
      t.string :Unit
      t.decimal :Picking_Amount
      t.decimal :BackQty
      t.decimal :CanbackQty
      t.string :PickingFor
      t.string :Asset_seat
      t.string :Picking_seat
      t.string :FSrcFbillno
      t.string :FSrcFseq
      t.string :AssetPicking_id

      t.timestamps
    end
  end
end
