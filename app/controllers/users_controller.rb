class UsersController < ApplicationController
    before_action :setOwnerId

    def new
        @user = CafeteriaUser.new
    end

    def index
        @pendingCount = Order.where(status: "pending").count
        @completedCount = Order.where(status: "completed").count
        @totalCount = Order.all.count
    end

    def create
        @user = CafeteriaUser.new(user_params)
        if @user.save
            flash[:notice] = "Cafeteria User was created successfully."
            @user.save()
            redirect_to users_path
            # or we can write like this
            #redirect_to @article
        else
            render "new"
        end
    end

    def viewPendingOrders
        @pendingOrders = Order.where("status = 'pending' AND owner_id = ?", @owner_id)
        render "pendingOrders"
    end

    def viewCompletedOrders
        @completedOrders = Order.where("status = 'completed' AND owner_id = ?", @owner_id)
        render "completedOrders"
    end

    def completeOrder
        @order = Order.find(params[:id])
        @order.status = "completed"
        @order.save
        flash[:notice] = "Order Status Updated Successfully."
        redirect_to users_path
    end

    def createOrder
        session[:user_id] = Customer.where(email: "default@cafe.com").ids[0]
        redirect_to cafeteria_profile_path(session[:user_id])
    end

    def allOrders
        @allOrders = Order.where(owner_id: @owner_id)
        render "orderHistory"
    end

    def destroy
        @user.destroy
        redirect_to owner_view_users_path
    end

    private
    def user_params
        params.require(:cafeteria_user).permit(:email, :password)
    end

    def setOwnerId
        @owner_id = OwnerUser.where(cafeteria_user_id: session[:user_id]).first.cafeteria_owner_id
    end
end
