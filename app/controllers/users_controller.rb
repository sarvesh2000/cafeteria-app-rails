class UsersController < ApplicationController
    def new
        @user = CafeteriaUser.new
    end

    def index
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

    private
    def user_params
        params.require(:cafeteria_user).permit(:email, :password)
    end
end
