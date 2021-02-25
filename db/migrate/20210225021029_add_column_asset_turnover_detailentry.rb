class AddColumnAssetTurnoverDetailentry < ActiveRecord::Migration[6.0]
  def change
    remove_column :asset_turnover_detail_entries, :Type_of_business
     
    add_column  :asset_turnover_detail_entries, :FSrcFbillno, :string
    add_column  :asset_turnover_detail_entries, :FSrcFseq, :string
  end
end
