class CreateAssetalters < ActiveRecord::Migration[6.0]
  def change
    create_table :assetalters do |t|
      t.string :Fbillno
      t.string :Code
      t.string :name
      t.date :Alterdate
      t.string :Reason

      t.timestamps
    end
  end
end
