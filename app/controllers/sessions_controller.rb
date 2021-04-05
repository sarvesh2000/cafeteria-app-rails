class SessionsController < ApplicationController
    def new
    end

    def newCustomer
    end

    def create
        user = CafeteriaUser.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            # flash[:notice] = "Logged in successfully"
            redirect_to users_path
        else
            flash.now[:alert] = "There was something wrong with your login details"
            render 'new'
        end
    end

    def createCustomer
        user = Customer.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            # flash[:notice] = "Logged in successfully"
            redirect_to customers_path
        else
            flash.now[:alert] = "There was something wrong with your login details"
            render 'newCustomer'
        end
    end

    def newOwner
        render "newOwner"
    end

    def createOwner 
        user = CafeteriaOwner.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            # flash[:notice] = "Logged in successfully"
            redirect_to owners_path
        else
            flash.now[:alert] = "There was something wrong with your login details"
            render 'newOwner'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "Logged out"
        redirect_to root_path
    end
end
