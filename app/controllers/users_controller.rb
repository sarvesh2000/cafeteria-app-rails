class UsersController < ApplicationController
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
            #flash[:notice] = "Article was created successfully."
            @user.save()
            redirect_to users_path
            # or we can write like this
            #redirect_to @article
        else
            render "new"
        end
    end

    def viewPendingOrders
        @pendingOrders = Order.where(status: "pending")
        render "pendingOrders"
    end

    def viewCompletedOrders
        @completedOrders = Order.where(status: "completed")
        render "completedOrders"
    end

    def completeOrder
        @order = Order.find(params[:id])
        @order.status = "completed"
        @order.save
        redirect_to users_path
    end

    private
    def user_params
        params.require(:cafeteria_user).permit(:email, :password)
    end
end
