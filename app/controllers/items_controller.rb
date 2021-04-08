class ItemsController < ApplicationController
    before_action :check_session_user, except: [:addToCart, :removeFromCart]
    before_action :set_item, only: [:show, :update, :edit, :destroy]
    
    def index
        @items = Item.where("cafeteria_owner_id", session[:user_id])
    end

    def show
    end

    def create
        @item = Item.new(items_params)
        if @item.save
            flash[:notice] = "Item created."
            @item.save()
            redirect_to items_path(@item)
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
            flash[:notice] = "Item updated."
            redirect_to(items_path)
        else
            render "edit"
        end
    end

    def destroy
        @item.destroy
        flash[:notice] = "Item Deleted"
        redirect_to items_path
    end

    def addToCart
        id = params[:id]
        @cart = CartItem.where(customer_id: session[:user_id])
        if @cart == nil
            puts "Cart Created Newly 1"
            @cart = CartItem.create(item_id: id, quantity: 1, customer_id: session[:user_id])
        else
            puts "Checking Current Item"
            current_item = @cart.where(item_id: id)
            if !current_item.empty?
                puts "Current Item Found"
                puts current_item
                current_item.first.quantity += 1
                current_item.first.save
            else
                puts "Current Item Not Found"
                @cart = CartItem.create(item_id: id, quantity: 1, customer_id: session[:user_id])
                puts "New Item Saved"
            end
        end
        flash[:notice] = "Added Item to cart"
        redirect_to cafeteria_profile_path(session[:cafeteria_id])
    end

    def removeFromCart
        id = params[:id]
        @cart = CartItem.where(customer_id: session[:user_id])
        puts "Found Cart"
        if @cart
            puts "Inside Cart if"
            current_item = @cart.where(item_id: id)
            if current_item.first.quantity > 1
                puts "Reducing quantity"
                current_item.first.quantity -= 1
                puts "Reduced quantity"
                current_item.first.save
            else
                puts "Removing entire item"
                current_item.destroy_all
            end
        end
        flash[:notice] = "Removed Item to cart"
        redirect_to cafeteria_profile_path(session[:cafeteria_id])
    end

    private
    
    def items_params
        params.require(:item).permit(:item_name, :available_stock, :price, :cafeteria_owner_id)
    end

    def set_item
        @item = Item.find(params[:id])
    end

    def check_session_user
        if session[:user_type] != "Cafe Owner"
            redirect_to unauthorised_path
        end
    end
end
