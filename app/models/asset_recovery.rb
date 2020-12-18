class AssetRecovery < ApplicationRecord
    has_many :AssetRecoveryEntry
    validates :Document_number, presence: true,uniqueness: true
end
