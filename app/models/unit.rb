class Unit < ApplicationRecord
    validates :Unitcode, presence: true ,uniqueness: true
    validates :name, presence: true,uniqueness: true
end
