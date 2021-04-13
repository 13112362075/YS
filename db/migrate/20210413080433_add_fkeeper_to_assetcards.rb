class AddFkeeperToAssetcards < ActiveRecord::Migration[6.0]
  def change
    add_column  :assetcards, :FKeeper, :string
  end
end
