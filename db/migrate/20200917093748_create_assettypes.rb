class CreateAssettypes < ActiveRecord::Migration[6.0]
  def change
    create_table :assettypes do |t|
      t.string :Assettypecode
      t.string :Name
      t.integer :Orgainize_id
      t.string :description

      t.timestamps
    end
  end
end
