module CustomersHelper
    def findItemName(item)
        Item.find(item.item_id).item_name
    end
end
