class CustomersController < ApplicationController
    before_action :check_session_user
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
            flash[:notice] = "Signup Successful"
            @user.save()
            session[:user_id] = @user.id
            session[:user_type] = "Customer"
            redirect_to customers_path
            # or we can write like this
            #redirect_to @article
        else
            flash[:notice] = "There\'s some error in signing up. Try again."
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
            @order.customer_id = session[:user_id]
            @order.owner_id = session[:cafeteria_id]
            @order.save
            @order_items.order_id = @order.id
            @order_items.save
        end
        flash[:notice] = "Order Placed Successfully."
        if session[:cafe_user_id]
            session[:user_id] = session[:cafe_user_id]
            session[:user_type] = "Cafe User"
            redirect_to users_path
        else
            redirect_to customers_path
        end
    end

    def viewCafeteria
        session[:cafeteria_id] = params[:cafeteria_id]
        @items = CafeteriaOwner.find(params[:cafeteria_id]).items
        @cafeteria_name = CafeteriaOwner.find(params[:cafeteria_id]).cafeteria_name
        render "cafeteriaProfile"
    end

    def orderHistory
        @orders = Order.where(customer_id: session[:user_id])
        render "orderHistory"
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

    def check_session_user
        if session[:user_type] != "Customer"
            redirect_to unauthorised_path
        end
    end
end
