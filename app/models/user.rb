class User < ApplicationRecord
    belongs_to :department
    validates :account, presence: true ,uniqueness: true
  
end
