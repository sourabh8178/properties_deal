class PropertiesController < ApplicationController
  before_action :check_profile_for_agent

  def index
    @properties = current_user.properties
  end

  def new
    @property = Property.new
  end

  def create
    @property = current_user.properties.create(property_params)
    if @property.save 
      @property.update(images: params[:property][:images].compact_blank)
      flash[:notice] = "Your Property Has Been Created."
      redirect_to properties_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    @property = Property.find(params[:id])
  end

  private

  def property_params   
    params.require(:property).permit(:name,:description, :size, :price, :amenities, :location, :property_type, :bedrooms, :bathrooms, :parking, :images)
  end

end
