class AddColumnToCreateAssetPickingEntries < ActiveRecord::Migration[6.0]
  def change
    add_column  :asset_picking_entries, :Deptment, :string
    add_column  :asset_picking_entries, :Employeeld, :string
  end
end
