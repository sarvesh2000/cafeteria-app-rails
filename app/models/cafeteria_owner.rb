class CafeteriaOwner < ApplicationRecord
    has_secure_password
    has_many :items
    has_many :owner_users
    has_many :cafeteria_users
    acts_as_authentic do |c|
        # c.my_config_option = my_value # for available options see documentation in: Authlogic::ActsAsAuthentic
        c.crypto_provider = Authlogic::CryptoProviders::BCrypt
    end
end
