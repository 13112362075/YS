class AddColumnToAssettype < ActiveRecord::Migration[6.0]
  def change
    add_column  :assetseates, :ParentAssettype, :string
    add_column  :assetseates, :Level, :string
  end
end
