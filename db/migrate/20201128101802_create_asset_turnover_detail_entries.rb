class CreateAssetTurnoverDetailEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :asset_turnover_detail_entries do |t|
      t.string :assetcards_Code
      t.string :assetcards_name
      t.string :Unit
      t.decimal :Amount
      t.string :Reasons_for
      t.string :_borrowing
      t.date :givebackPlanDate
      t.string :Has_Been_returned
      t.date :givebackDate
      t.string :Deptment
      t.string :Employeeld
      t.string :Asset_seat
      t.string :Last_seat
      t.integer :AssetTurnoverDetail_id

      t.timestamps
    end
  end
end
