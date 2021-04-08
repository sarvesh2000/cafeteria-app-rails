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
        @cart = Cart.find(session[:cart])
        @cart.cart_items.each do |item|
            @order = Order.new
            @order_items = OrderItem.new
            @item = Item.find(item.item_id)
            @order.item_id = @item.id
            @order_items.item_id = @item.id
            @order.amount = (@item.price * item.quantity)
            @order.quantity = item.quantity
            @order.status = "pending"
            @order.customer_id = session[:user_id]
            @order.owner_id = session[:cafeteria_id]
            @order.save
            @order_items.order_id = @order.id
            @order_items.save
        end
        @cart.destroy
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
        puts "Session Cart Cafe Function"
        puts @cart
        # @cart = Cart.find(session[:cart])
        # puts "CArt"
        # puts @cart
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
        puts "Session Cart Initialise"
        session[:cart] ||= nil
    end

    def load_cart
        puts "Load"
        puts "Load Session Cart"
        puts session[:cart]
        @cart = Cart.find(session[:cart])
        session[:cart] = @cart.id
        puts "Before Rescue"
        rescue ActiveRecord::RecordNotFound
        puts "After Rescue"
        @cart = Cart.new
        @cart.customer_id = session[:user_id]
        @cart.save
        puts "Saved"
        puts "Cart ID"
        puts @cart.id
        session[:cart] = @cart.id
        puts "End"
    end

    def check_session_user
        if session[:user_type] != "Customer"
            redirect_to unauthorised_path
        end
    end
end
