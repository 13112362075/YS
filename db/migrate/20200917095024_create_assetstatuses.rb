class CreateAssetstatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :assetstatuses do |t|
      t.string :Assetstatuscode
      t.string :Name
      t.integer :Orgainize_id
      t.string :description

      t.timestamps
    end
  end
end
