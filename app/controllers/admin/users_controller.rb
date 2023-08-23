class Admin::UsersController < ApplicationController
	before_action :set_user, only: %i[ show edit update destroy ]
	 
	 def index
		@users = User.all
	 end

	 def new
	 	@user = User.new
	 end

	 def edit
	 end

	 def show
	 end

	def create
		@user = User.new(user_params)		
    if @user.save
      redirect_to admin_user_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
	end

	def update
		if params[:user][:password].present? && @user.update(user_params)
	    redirect_to admin_user_path(@user)
	  elsif @user.update(user_params_without_pass)
	    redirect_to  admin_user_path(@user)
	  else
	    render :edit, status: :unprocessable_entity
	  end
  end

	def destroy
    @user.delete    
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: "Picture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

	private

	def set_user
		@user = User.find(params[:id])
	end
	def user_params_without_pass
		params.require(:user).permit(:email, :company_id, :role)
	end
	def user_params
		params.require(:user).permit(:email, :password, :company_id, :role)
	end
end