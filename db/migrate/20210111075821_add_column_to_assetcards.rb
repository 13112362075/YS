class AddColumnToAssetcards < ActiveRecord::Migration[6.0]
  def change
    add_column  :assetcards, :Creator, :string
    add_column  :assetcards, :Createdate, :datetime
    add_column  :assetcards, :Approver, :string
    add_column  :assetcards, :Approverdate, :datetime
  end
end
