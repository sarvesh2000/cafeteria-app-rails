class CustomersController < ApplicationController
    before_action :initialize_cart
    before_action :load_cart
    def new
        @user = Customer.new
    end

    def index
        @cafeterias = CafeteriaOwner.all
        # @items = Item.all
    end

    def create
        @user = Customer.new(user_params)
        if @user.save
            #flash[:notice] = "Article was created successfully."
            @user.save()
            redirect_to customers_path
            # or we can write like this
            #redirect_to @article
        else
            render "new"
        end
    end

    def checkout
        @cart = load_cart
        @cart.each do |item|
            @order = Order.new
            @order_items = OrderItem.new
            @item = Item.find(item.id)
            @order.item_id = @item.id
            @order_items.item_id = @item.id
            @order.amount = (@item.price * session[:cart][0][@item.id.to_s])
            @order.quantity = session[:cart][0][@item.id.to_s]
            @order.status = "pending"
            @order.save
            @order_items.order_id = @order.id
            @order_items.save
        end
        return redirect_to customers_path
    end

    def viewCafeteria
        session[:cafeteria_id] = params[:cafeteria_id]
        @items = CafeteriaOwner.find(params[:cafeteria_id]).items
        @cafeteria_name = CafeteriaOwner.find(params[:cafeteria_id]).cafeteria_name
        render "cafeteriaProfile"
    end

    private
    def user_params
        params.require(:customer).permit(:email, :password)
    end

    def initialize_cart
        session[:cart] ||= []
    end

    def load_cart
        if session[:cart][0]
            @cart = Item.find(session[:cart][0].keys)
        else
            @cart = []
        end
    end
end
