class CreateUsestates < ActiveRecord::Migration[6.0]
  def change
    create_table :usestates do |t|
      t.string :Usestatecode
      t.string :Name
      t.integer :Orgainize_id
      t.string :Description

      t.timestamps
    end
  end
end
