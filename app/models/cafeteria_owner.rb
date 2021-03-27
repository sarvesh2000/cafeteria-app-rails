class CafeteriaOwner < ApplicationRecord
    has_secure_password
    has_many :owner_items
    has_many :items, :through => :owner_items
end
