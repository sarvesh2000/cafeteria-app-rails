class Customer < ApplicationRecord
    has_secure_password
    has_many :orders
    has_many :cart_items 
    acts_as_authentic do |c|
        # c.my_config_option = my_value # for available options see documentation in: Authlogic::ActsAsAuthentic
        c.crypto_provider = Authlogic::CryptoProviders::BCrypt
    end
end
