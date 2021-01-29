class AddColumnFseqToCreateAssetPickingEntries < ActiveRecord::Migration[6.0]
  def change
    add_column  :asset_picking_entries, :assetstatus, :string
    add_column  :asset_picking_entries, :fseq, :string
  end
end
