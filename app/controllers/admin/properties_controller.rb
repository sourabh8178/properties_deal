class Admin::PropertiesController < ApplicationController
	before_action :set_property, only: %i[ show edit update destroy ]
	def index
		@properties = Property.all.paginate(:page => params[:page], :per_page => 10)
	end

	def new
		@property = Property.new
	end

	def show
	end

	def edit
	end

	def create
		@property = Property.new(property_params)
		@property.status_type = params[:property][:status_type].to_i
		@property.user_id = params[:property][:user_id].to_i
    if @property.save
			@property.update(images: params[:property][:images].compact_blank)
			flash[:notice] = "Your Property Has Been Created."
			redirect_to admin_properties_path
    else
      render :new, status: :unprocessable_entity
    end
	end

	def update
		status_type = params[:property][:status_type].to_i
		# update = property_params.merge()
    if @property.update(property_params.merge(status_type: status_type))
    	if params[:property][:images].compact_blank.present?
    		@property.update(images: params[:property][:images])
    		# @property.images.attached(params[:property][:images])
    	end
			flash[:notice] = "Your Property Has Been Updated."
      redirect_to  admin_properties_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

	def destroy
    @property.delete
    respond_to do |format|
      format.html { redirect_to admin_properties_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

	private
	 def set_property
	 	@property = Property.find(params[:id])
	 end

	 def property_params		
	 	params.require(:property).permit(:name,:description, :size, :price, :amenities, :location, :property_type, :bedrooms, :bathrooms, :parking, :images)
	 end
end