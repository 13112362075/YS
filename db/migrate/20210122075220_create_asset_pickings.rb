class CreateAssetPickings < ActiveRecord::Migration[6.0]
  def change
    drop_table :asset_pickings
    create_table :asset_pickings do |t|
      t.string :FBillno
      t.string :Type_of_business
      t.datetime :Picking_Date
      t.string :Picking_Dept
      t.string :Picking_Employeeld
      t.string :Fbillstatus
      t.string :Creator
      t.string :Approver
      t.datetime :CreateDate
      t.datetime :ApproveDate

      t.timestamps
    end
  end
end
