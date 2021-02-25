class AddColumn2AssetTurnoverDetailentry < ActiveRecord::Migration[6.0]
  def change
    remove_column :asset_turnover_detail_entries, :givebackPlanDate
    remove_column :asset_turnover_detail_entries, :Has_Been_returned
    remove_column :asset_turnover_detail_entries, :givebackDate 
  end
end
