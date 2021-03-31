class OwnersController < ApplicationController
    def index
        @totalSalesToday = Order.where("DATE(created_at) = ?", Date.today).sum("amount")
        @totalOrdersToday = Order.where("DATE(created_at) = ?", Date.today).count
        @totalSalesWeek = Order.where("DATE(created_at) BETWEEN ? AND ?", Date.today.beginning_of_week, Date.today.end_of_week).sum("amount")
    end

    def new
        @owner = CafeteriaOwner.new
    end

    def create
        @owner = CafeteriaOwner.new(owner_params)
        if @owner.save
            #flash[:notice] = "Article was created successfully."
            @owner.save()
            redirect_to owners_path
            # or we can write like this
            #redirect_to @article
        else
            render "new"
        end
    end

    def viewOrders
        @orders = Order.where("owner_id", session[:user_id])
        render "viewOrders"
    end

    def viewUsers
        @users = OwnerUser.where("cafeteria_owner_id", session[:user_id])
        render "viewUsers"
    end

    private
    def owner_params
        params.require(:cafeteria_owner).permit(:email, :password, :cafeteria_name)
    end
end
