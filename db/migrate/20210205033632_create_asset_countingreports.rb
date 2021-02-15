class CreateAssetCountingreports < ActiveRecord::Migration[6.0]
  def change
    drop_table :asset_countingreports
    create_table :asset_countingreports do |t|
      t.string :BillNo
      t.string :description
      t.string :Creator
      t.datetime :CREATEDATE
      t.string :Approver
      t.string :APPROVEDATE
      t.string :fbillstatus
      t.datetime :fdate

      t.timestamps
    end
  end
end
