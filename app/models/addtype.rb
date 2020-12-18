class Addtype < ApplicationRecord
    validates :Addtypecode, presence: true ,uniqueness: true
    validates :Name, presence: true,uniqueness: true
end
