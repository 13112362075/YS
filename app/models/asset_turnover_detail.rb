class AssetTurnoverDetail < ApplicationRecord
    has_many :AssetTurnoverDetailEntry
    validates :Document_number, presence: true,uniqueness: true
end
