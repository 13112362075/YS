class CreateAssetAllocates < ActiveRecord::Migration[6.0]
  def change
    drop_table :asset_allocates
    create_table :asset_allocates do |t|
      t.string :FBillno
      t.datetime :Expdate
      t.string :Allocate_reason
      t.string :FBillstatus
      t.string :Creator
      t.string :Approver
      t.datetime :CREATEDATE
      t.datetime :APPROVEDATE

      t.timestamps
    end
  end
end
