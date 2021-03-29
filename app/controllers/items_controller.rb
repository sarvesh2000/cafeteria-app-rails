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

    def addToCart
        puts "Request Params"
        puts request.params
        id = params[:id]
        
        if session[:cart].empty?
            cartHash = Hash.new
            cartHash.store(id, 1)
            session[:cart] << cartHash
        else
            if session[:cart][0].has_key?(id)
                count = session[:cart][0][id]
                puts count
                session[:cart][0][id] = count+1
            else
                session[:cart][0].store(id, 1)
            end
        end
        redirect_to cafeteria_profile_path(session[:cafeteria_id])
    end

    def removeFromCart
        id = params[:id]
        if session[:cart][0][id] > 1
            value = session[:cart][0][id] - 1
            session[:cart][0][id] = value
        else
            session[:cart][0].delete(id)
        end
        redirect_to cafeteria_profile_path(session[:cafeteria_id])
    end

    private
    
    def items_params
        params.require(:item).permit(:item_name, :available_stock, :price)
    end

    def set_item
        @item = Item.find(params[:id])
    end
end
