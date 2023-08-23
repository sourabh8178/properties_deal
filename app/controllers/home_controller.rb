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
    @properties = Property.order('RANDOM()').limit(6)
    # if (params[:rangeValue].to_i > 0 && params[:rangeValue].present?)
    #   @properties = @properties.where('price < ?', params[:rangeValue].to_i)
    # end
    # if params[:bedrooms].present?
    #   @properties = @properties.where(bedrooms: params[:bedrooms])
    # end
    # if params[:bathrooms].present?
    #   @properties = @properties.where(bathrooms: params[:bathrooms])
    # end
    # if params[:location].present?
    #   @properties = @properties.where(location: params[:location])
    # end
    @agents = User.agents
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
    @properties = Property.all
  end

  def agent_list
    @agents = User.agents
  end

  def about
    
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
end
