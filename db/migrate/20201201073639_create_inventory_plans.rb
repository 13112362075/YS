class CreateInventoryPlans < ActiveRecord::Migration[6.0]
  def change
    create_table :inventory_plans do |t|
      t.string :Document_number
      t.string :Name
      t.string :To_id
      t.string :description

      t.timestamps
    end
  end
end
