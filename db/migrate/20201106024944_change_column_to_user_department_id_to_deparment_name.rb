class ChangeColumnToUserDepartmentIdToDeparmentName < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :department_id, :departmentname
  end
end
