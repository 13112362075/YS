class AddColumnToAssetDisposalEntry < ActiveRecord::Migration[6.0]
  def change
    add_column  :asset_disposal_entries, :Usestate_id, :string
  end
end
