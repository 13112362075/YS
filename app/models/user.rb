class User < ApplicationRecord
    belongs_to :department ,:primary_key => "departmentname", :foreign_key => "departmentname"
 
end
