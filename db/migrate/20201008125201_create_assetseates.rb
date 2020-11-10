class CreateAssetseates < ActiveRecord::Migration[6.0]
  def change
    create_table :assetseates do |t|
      t.string :Assetseatecode
      t.string :Name
      t.integer :Orgainize_id
      t.string :Description

      t.timestamps
    end
  end
end
