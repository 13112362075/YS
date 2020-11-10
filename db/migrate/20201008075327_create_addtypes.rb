class CreateAddtypes < ActiveRecord::Migration[6.0]
  def change
    create_table :addtypes do |t|
      t.string :Addtypecode
      t.string :Name
      t.integer :Orgainize_id
      t.string :Description

      t.timestamps
    end
  end
end
