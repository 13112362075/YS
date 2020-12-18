class Usestate < ApplicationRecord
    validates :Usestatecode, presence: true ,uniqueness: true
    validates :Name, presence: true,uniqueness: true
end
