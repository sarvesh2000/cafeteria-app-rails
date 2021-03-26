class CustomersController < ApplicationController
    before_action :initialize_cart
    before_action :load_cart
    def new
        @user = Customer.new
    end

    def index
        @items = Item.all
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
        byebug
        @cart.each do |item|
            @order = Order.new
            @item = Item.find(item.id)
            @order.item_id = @item.id
            @order.amount = @item.price
            @order.quantity = 1
            @order.save
        end
        return redirect_to customers_path
    end

    private
    def user_params
        params.require(:customer).permit(:email, :password)
    end

    def initialize_cart
        session[:cart] ||= []
    end

    def load_cart
        @cart = Item.find(session[:cart])
    end
end
