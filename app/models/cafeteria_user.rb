class CafeteriaUser < ApplicationRecord
    has_one :cafeteria_owner
    acts_as_authentic do |c|
        # c.my_config_option = my_value # for available options see documentation in: Authlogic::ActsAsAuthentic
        c.crypto_provider = Authlogic::CryptoProviders::BCrypt
    end
end
