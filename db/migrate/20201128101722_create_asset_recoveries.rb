class CreateAssetRecoveries < ActiveRecord::Migration[6.0]
  def change
    create_table :asset_recoveries do |t|
      t.string :Documentnumber
      t.string :Type_of_business
      t.date :Requisition_Date

      t.timestamps
    end
  end
end
