class AddColumnToDepartments < ActiveRecord::Migration[6.0]
  def change
    add_column  :departments, :fbillstatus, :string
    add_column  :departments, :Creator, :string
    add_column  :departments, :CreateDate, :datetime
    add_column  :departments, :Approver, :string
    add_column  :departments, :ApproverDate, :datetime
  end
end
