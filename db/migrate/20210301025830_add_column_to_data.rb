class AddColumnToData < ActiveRecord::Migration[6.0]
  def change
    add_column  :addtypes, :fbillstatus, :string
    add_column  :addtypes, :Creator, :string
    add_column  :addtypes, :CreateDate, :datetime
    add_column  :addtypes, :Approver, :string
    add_column  :addtypes, :ApproverDate, :datetime

    add_column  :assettypes, :fbillstatus, :string
    add_column  :assettypes, :Creator, :string
    add_column  :assettypes, :CreateDate, :datetime
    add_column  :assettypes, :Approver, :string
    add_column  :assettypes, :ApproverDate, :datetime

    add_column  :assetstatuses, :fbillstatus, :string
    add_column  :assetstatuses, :Creator, :string
    add_column  :assetstatuses, :CreateDate, :datetime
    add_column  :assetstatuses, :Approver, :string
    add_column  :assetstatuses, :ApproverDate, :datetime


    add_column  :units, :fbillstatus, :string
    add_column  :units, :Creator, :string
    add_column  :units, :CreateDate, :datetime
    add_column  :units, :Approver, :string
    add_column  :units, :ApproverDate, :datetime

    add_column  :usestates, :fbillstatus, :string
    add_column  :usestates, :Creator, :string
    add_column  :usestates, :CreateDate, :datetime
    add_column  :usestates, :Approver, :string
    add_column  :usestates, :ApproverDate, :datetime

    add_column  :assetseates, :fbillstatus, :string
    add_column  :assetseates, :Creator, :string
    add_column  :assetseates, :CreateDate, :datetime
    add_column  :assetseates, :Approver, :string
    add_column  :assetseates, :ApproverDate, :datetime
  end
end
