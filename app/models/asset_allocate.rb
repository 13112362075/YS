class AssetAllocate < ApplicationRecord
    has_many :AssetAllocateEntry
    validates :Document_number, presence: true,uniqueness: true
end
