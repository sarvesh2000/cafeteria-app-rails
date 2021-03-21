class ItemsController < ApplicationController
    def index
        @items = Item.all
    end

    def create
        @items = Item.new(items_params)
        if @items.save
            #flash[:notice] = "Article was created successfully."
            @items.save()
            redirect_to items_path(@item)
            # or we can write like this
            #redirect_to @article
        else
            render "new"
        end
    end

    def new
        @items = Item.new
    end

    def items_params
        params.permit(:item_name, :available_stock)
    end
end
