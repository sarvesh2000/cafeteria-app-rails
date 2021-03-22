class OwnersController < ApplicationController
    def index
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

    private
    def owner_params
        params.require(:cafeteria_owner).permit(:email, :password, :cafeteria_name)
    end
end
