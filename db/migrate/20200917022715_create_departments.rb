class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments do |t|
      t.string :departmentcode
      t.string :departmentname
      t.integer :organize_id
      t.string :description

      t.timestamps
    end
  end
end
