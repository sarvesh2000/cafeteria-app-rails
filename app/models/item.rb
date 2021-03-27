class Item < ApplicationRecord
    validates :item_name, presence: true, length: { minimum: 3 }
    validates :available_stock, presence: true
    has_many :order_items
    has_many :orders, :through => :order_items
end
