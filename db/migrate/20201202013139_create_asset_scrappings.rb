class CreateAssetScrappings < ActiveRecord::Migration[6.0]
  def change
    drop_table:asset_scrappings
    create_table :asset_scrappings do |t|
      t.string :Document_number
      t.date :Date
      t.string :Addtype
      t.string :Addtype_Reason

      t.timestamps
    end
  end
end
