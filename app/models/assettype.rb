class Assettype < ApplicationRecord
    validates :Assettypecode, presence: true ,uniqueness: true
    validates :Name, presence: true,uniqueness: true
end
