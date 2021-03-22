class CustomersController < ApplicationController
    def new
        @user = Customer.new
    end

    def index
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

    private
    def user_params
        params.require(:customer).permit(:email, :password)
    end
end
