class Addfbillstatustoassetcards < ActiveRecord::Migration[6.0]
  def change
    add_column  :assetcards, :fbillstatus, :string
  end
end
