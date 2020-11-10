class ChangeColumnUserDepartmentId < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :department_id, :string
  end
end
