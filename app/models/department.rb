class Department < ApplicationRecord
    has_many :user  ,:primary_key => "departmentname", :foreign_key => "departmentname"
    validates :departmentcode, presence: true ,uniqueness: true
    validates :departmentname, presence: true,uniqueness: true
end
