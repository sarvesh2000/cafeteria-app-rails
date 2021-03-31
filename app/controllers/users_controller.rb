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

    def createOrder
        session[:user_id] = Customer.where(email: "default@cafe.com").ids[0]
        redirect_to cafeteria_profile_path(session[:user_id])
    end

    def destroy
        @user.destroy
        redirect_to owner_view_users_path
    end

    private
    def user_params
        params.require(:cafeteria_user).permit(:email, :password)
    end
end
