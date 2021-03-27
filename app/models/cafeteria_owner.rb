class CafeteriaOwner < ApplicationRecord
    has_secure_password
    has_many :items, :through => :owner_items
end
