class AddColumnAssetTurnoverDetail < ActiveRecord::Migration[6.0]
  def change
    add_column  :asset_turnover_details, :Type_of_business, :string
    
  end
end
