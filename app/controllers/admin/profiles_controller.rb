class Admin::ProfilesController < ApplicationController
		before_action :set_profile, only: %i[ show edit update destroy ]

	def index
		@profiles = Profile.all.paginate(:page => params[:page], :per_page => 10)
	end

	def show
	end

	def new
		@profile = Profile.new
		user = User.all
		@users = []
		user.each do |agent|
			if !agent.profile.present? && agent.role != "admin"
				@users << agent
			end
		end
	end

	def create
		@profile = Profile.new(property_params)
		if @profile.save
			flash[:notice] = "Your Property Has Created."
			redirect_to admin_profiles_path
		else
      render :new, status: :unprocessable_entity
		end
	end

	def edit
		# user = User.all
		@users = User.all
		# user.each do |agent|
		# 	if !agent.profile.present? && agent.role != "admin"
		# 		@users << agent
		# 	end
		# end
	end

	def update
		@profile.update(property_params)
		if @profile.save
			flash[:notice] = "Your Property Has Updated."
			redirect_to admin_profiles_path
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@profile.destroy
		redirect_to (request.referer)
	end

	private

	 def set_profile
		@profile = Profile.find(params[:id])
	 end

	 def property_params		
	 	params.require(:profile).permit(:name,:user_id, :mobile_number, :address, :profile_image, :is_complete, :about)
	 end
end