class AddColumnAssetalter < ActiveRecord::Migration[6.0]
  def change
    add_column  :assetalters, :Usestate_id, :string
    add_column  :assetalters, :Usestate_id_Old, :string
  end
end
