class CreateAssetScrappingEntries < ActiveRecord::Migration[6.0]
  def change
    drop_table :asset_scrapping_entries
    create_table :asset_scrapping_entries do |t|
      t.string :Code
      t.string :Name
      t.string :Unit
      t.integer :Amount
      t.integer :Scrapping_Amount
      t.string :Asset_seat
      t.integer :Asset_Scrapping_id

      t.timestamps
    end
  end
end
