class CafeteriaOwner < ApplicationRecord
    has_secure_password
    has_many :items
    has_many :owner_users
    has_many :cafeteria_users
end
