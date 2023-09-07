class HomeController < ApplicationController

  def grad
    @agents = User.agents
  end

  def show
    @property = Property.find(params[:id])
    @recamend_properties = Property.order('RANDOM()').limit(6)
    @feedback = Feedback.new
    @feedbacks = @property.feedbacks
  end

  def property_view
    # @recamend_properties = Property.order('RANDOM()').limit(7)
    @property = Property.find(params[:id])
  end

  def index
    if current_user&.present? && !current_user&.profile.present?
        redirect_to(profile_path)
    else
        @properties = Property.order('RANDOM()').limit(6)
        @agents = User.agents
    end
    # @posts = Post.all
  end


  def property_view
    @property = Property.find(params[:id])
    @agent = User.agents.last(3)
    @feedbacks = @property.feedbacks
    @properties = Property.order('RANDOM()').limit(3)
  end

  def agent_view
    @user = User.find(params[:id])
    @agent_profile = @user.profile
    @company = @user.company
    @property = @user.properties
  end

  def view_all_property
    conditions = {}
    conditions[:status] = params[:status ] if params[:status ].present?
    conditions[:property_type] = params[:property] if params[:property].present?
    conditions[:location] = params[:location] if params[:location].present?
    @properties = Property.where(conditions).paginate(:page => params[:page], :per_page => 10)
    if (params[:rangeValue].to_i > 0 && params[:rangeValue].present?)
      @properties = @properties.where('price < ?', params[:rangeValue].to_i)
    end
  end

  def agent_list
    @agents = User.agents
  end

  def about
    
  end

  def password_change
    if current_user.valid_password?(params[:currentPassword])
      if (params[:password] == params[:confirmPassword])
        @users = current_user.update(password: params[:password])
      else
        flash[:notice] = "Your password does not match Confirm Password"
        redirect_to(request.referer)
      end
    else
      flash[:notice] = "Your current password does not match"
      redirect_to(request.referer)
    end
  end

  def message
    @single_room = Room.find_by(user_id: current_user.id, sender_id: params[:agent_id].to_i) || Room.find_by(user_id: params[:agent_id].to_i, sender_id: current_user.id)
    if @single_room.present?
      redirect_to "/rooms/#{@single_room.id}"
    else
      @single_room = Room.create(user_id: current_user.id, sender_id: params[:agent_id].to_i)
      redirect_to "/rooms/#{@single_room.id}"
    end
  end

  def profile
    if current_user.profile.present?
      @profile = current_user.profile
    else
      @profile = Profile.new
    end
  end

  def update_profile
    if current_user.profile.update(profile_params)
      flash[:notice] = "Profile updated successfuly."
      redirect_to(request.referer)
    end
  end

  def create_profile
    if params[:profile_image].present?
      @profile = Profile.new(profile_image: params[:profile_image], user_id: current_user.id)
      if @profile.save
        flash[:notice] = "Profile created successfuly."
        redirect_to(request.referer)
      end
    else
      @profile = Profile.new(name: params[:name], email: params[:email],mobile_number: params[:mobile_number], user_id: current_user.id, is_complete: true)
      if @profile.save
        flash[:notice] = "Profile created successfuly."
        redirect_to(request.referer)
      end
    end
  end

  def profile_about
  end

  def security
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :profile_image, :email, :mobile_number, :address, :location, :property_type, :bedrooms, :bathrooms, :parking, :images)
  end
end
