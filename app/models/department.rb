class Department < ApplicationRecord
    has_many :user  ,:primary_key => "departmentname", :foreign_key => "departmentname"
end