class AddColumnAddtypeIdToAssetDisposalEntry < ActiveRecord::Migration[6.0]
  def change
    add_column  :asset_disposal_entries, :Addtype_id, :string
  end
end
