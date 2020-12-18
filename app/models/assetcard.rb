class Assetcard < ApplicationRecord
    validates :assetCode, presence: true ,uniqueness: true
    validates :assetname, presence: true,uniqueness: true
end
