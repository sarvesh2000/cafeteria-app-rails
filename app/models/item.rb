class Item < ApplicationRecord
    validates :item_name, presence: true, length: { minimum: 3 }
    validates :available_stock, presence: true
end
