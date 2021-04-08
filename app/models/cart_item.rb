class CartItem < ApplicationRecord
    belongs_to :customer
    has_one :item
end
