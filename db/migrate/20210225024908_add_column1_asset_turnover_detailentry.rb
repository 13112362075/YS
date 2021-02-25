class AddColumn1AssetTurnoverDetailentry < ActiveRecord::Migration[6.0]
  def change
    add_column  :asset_turnover_detail_entries, :fseq, :string
  end
end
