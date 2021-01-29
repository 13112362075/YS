class CreateAssetDisposals < ActiveRecord::Migration[6.0]
  def change
    create_table :asset_disposals do |t|
      t.string :FBillno
      t.date :DisposeDate
      t.string :Disposemethod
      t.string :DisposeReason
      t.string :Fbillstatus
      t.string :Creator
      t.string :Approver
      t.datetime :CreateDate
      t.datetime :ApproveDate

      t.timestamps
    end
  end
end
