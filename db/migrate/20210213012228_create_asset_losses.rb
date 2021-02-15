class CreateAssetLosses < ActiveRecord::Migration[6.0]
  def change
    create_table :asset_losses do |t|
      t.string :BillNo
      t.string :description
      t.datetime :fdate
      t.string :fbillstatus
      t.string :Creator
      t.string :Approver
      t.string :CREATEDATE
      t.string :APPROVEDATE

      t.timestamps
    end
  end
end
