class CreateAssetTurnoverDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :asset_turnover_details do |t|
      t.string :Document_number
      t.date :Borrowing_date
      t.string :Borrowing_Department
      t.string :Borrowed_To_id
      t.string :Loaner

      t.timestamps
    end
  end
end
