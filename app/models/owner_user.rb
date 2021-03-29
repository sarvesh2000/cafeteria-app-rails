class OwnerUser < ApplicationRecord
    belongs_to :cafeteria_owner
    belongs_to :cafeteria_user
end
