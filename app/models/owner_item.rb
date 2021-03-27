class OwnerItem < ApplicationRecord
    belongs_to :item
    belongs_to :cafeteria_owner
end
