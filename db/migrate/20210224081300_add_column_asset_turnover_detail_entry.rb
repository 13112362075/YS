class AddColumnAssetTurnoverDetailEntry < ActiveRecord::Migration[6.0]
  def change
    
    add_column  :asset_turnover_detail_entries, :Type_of_business, :string
  end
end
