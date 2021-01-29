class AddColumnAssetstatusToCreateAssetPickingEntries < ActiveRecord::Migration[6.0]
  def change
    add_column  :asset_disposal_entries, :fseq, :string
    add_column  :asset_disposal_entries, :AssetDisposal_id, :string
  end
end
