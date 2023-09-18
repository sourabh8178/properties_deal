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
      flash[:notice] = "Your Property has Created."
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

  def update
    @property = Property.find(params[:id])
    if @property.update(property_params)
      flash[:notice] = "Your Property has Update."
      redirect_to properties_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def property_params   
    params.require(:property).permit(:name,:description, :size, :price, :amenities, :location, :property_type, :bedrooms, :bathrooms, :parking, :images, :status_type)
  end

end
