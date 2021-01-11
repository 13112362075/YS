class CreateAssetalterEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :assetalter_entries do |t|
      t.string :Altertype
      t.string :Information_Old
      t.string :Information_New
      t.integer :Assetalter_id

      t.timestamps
    end
  end
end
