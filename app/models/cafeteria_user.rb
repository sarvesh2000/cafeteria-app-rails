class CafeteriaUser < ApplicationRecord
    has_secure_password
    has_one :cafeteria_owner
end
