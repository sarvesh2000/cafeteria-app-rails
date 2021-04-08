class Item < ApplicationRecord
    validates :item_name, presence: true, length: { minimum: 3 }
    validates :available_stock, presence: true
    has_many :order_items
    has_one :cafeteria_owner
    has_many :cart_items
end
