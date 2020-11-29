class CreateAssetAllocates < ActiveRecord::Migration[6.0]
  def change
    create_table :asset_allocates do |t|
      t.string :Document_number
      t.string :Pull_up_to_id
      t.string :Bring_in_to_id
      t.date :Pull_up_date
      t.string :Allocate_reason
      t.string :Bring_in_Number
      t.string :Bring_in_Confirm

      t.timestamps
    end
  end
end
