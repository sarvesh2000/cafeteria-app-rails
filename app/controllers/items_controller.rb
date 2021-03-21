class ItemsController < ApplicationController
    before_action :set_item, only: [:show, :update, :edit, :destroy]
    
    def index
        @items = Item.all
    end

    def show
    end

    def create
        @item = Item.new(items_params)
        if @item.save
            #flash[:notice] = "Article was created successfully."
            @item.save()
            redirect_to items_path(@item)
            # or we can write like this
            #redirect_to @article
        else
            render "new"
        end
    end

    def new
        @item = Item.new
    end

    def edit
    end

    def update
        if @item.update(items_params)
            @item.save()
            redirect_to(items_path)
        else
            render "edit"
        end
    end

    def destroy
        @item.destroy
        redirect_to items_path
    end


    private
    
    def items_params
        params.require(:item).permit(:item_name, :available_stock)
    end

    def set_item
        @item = Item.find(params[:id])
    end
end
