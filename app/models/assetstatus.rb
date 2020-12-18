class Assetstatus < ApplicationRecord
    validates :Assetstatuscode, presence: true ,uniqueness: true
    validates :Name, presence: true,uniqueness: true
end
