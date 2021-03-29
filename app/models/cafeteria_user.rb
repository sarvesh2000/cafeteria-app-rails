class CafeteriaUser < ApplicationRecord
    has_secure_password
    has_many :owner_users
    has_one :cafeteria_owner, :through => :owner_users
end
