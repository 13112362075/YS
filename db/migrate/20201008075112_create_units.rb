class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units do |t|
      t.string :Unitcode
      t.string :name
      t.integer :Unitaccuracy
      t.string :Roundingtype
      t.timestamps
    end
  end
end
