class CafeteriaOwner < ApplicationRecord
    has_secure_password
    has_many :owner_items
    has_many :owner_users
    has_many :items, :through => :owner_items
    has_many :cafeteria_users, :through => :owner_users
end
