class User < ApplicationRecord
    belongs_to :department ,:primary_key => "departmentname", :foreign_key => "departmentname"
    validates :account, presence: true ,uniqueness: true
end
