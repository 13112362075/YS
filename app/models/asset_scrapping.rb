class AssetScrapping < ApplicationRecord
    validates :Document_number, presence: true,uniqueness: true
end
