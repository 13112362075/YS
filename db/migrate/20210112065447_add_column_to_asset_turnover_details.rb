class AddColumnToAssetTurnoverDetails < ActiveRecord::Migration[6.0]
  def change
    add_column  :asset_turnover_details, :Creator, :string
    add_column  :asset_turnover_details, :Createdate, :datetime
    add_column  :asset_turnover_details, :Approver, :string
    add_column  :asset_turnover_details, :Approverdate, :datetime
    add_column  :asset_turnover_details, :fbillstatus, :string
  end
end
