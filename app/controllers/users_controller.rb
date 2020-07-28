class UsersController < ApplicationController
    def new 
        @user = User.new
    end

    def create 
        @user = User.new user_params
        if @user.save 
            
            flash[:notice] = "Thank you for signing up!"
            redirect_to root_path
        else 
            flash[:warning] = "Unable to create user"
            render :new 
        end
    end

    def edit
        @user=User.find params[:id]
    end
    def update
       
    end

    private 

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
