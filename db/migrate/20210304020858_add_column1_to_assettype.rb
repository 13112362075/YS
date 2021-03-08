class AddColumn1ToAssettype < ActiveRecord::Migration[6.0]
  def change
    remove_column  :assetseates, :ParentAssettype, :string
    remove_column  :assetseates, :Level, :string
    add_column  :assettypes, :ParentAssettype, :string
    add_column  :assettypes, :Level, :string

    
  end
end
