class Assetseate < ApplicationRecord
    validates :Assetseatecode, presence: true ,uniqueness: true
    validates :Name, presence: true,uniqueness: true
end
