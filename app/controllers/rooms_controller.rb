class RoomsController < ApplicationController
  def index
    @current_user = current_user
    redirect_to '/signin' unless @current_user
    sender_ids = Room.where(user_id: 1).map(&:sender_id)
    @users = User.where(id: sender_ids)
    @room = Room.new
  end

  def show
    @chat_user = User.find_by(id: params[:sender_id].to_i)
    @current_user = current_user
    @single_room = Room.find(params[:id])
    sender_ids = Room.where(user_id: 1).map(&:sender_id)
    @users = User.where(id: sender_ids)
    @room = Room.new
    @message = Message.new
    @messages = @single_room.messages

    render "index"
  end

  def user_chat
    room = Room.find_by(user_id: current_user.id, sender_id: params[:sender_id].to_i) || Room.find_by(user_id: params[:sender_id].to_i, sender_id: current_user.id)
    if room.present?
      redirect_to "/rooms/#{room.id}?sender_id=#{params[:sender_id]}"
    else
      room = Room.create(user_id: current_user.id, sender_id: params[:sender_id].to_i)
      redirect_to "/rooms/#{room.id}?sender_id=#{params[:sender_id]}"
    end
  end

  def create
    @room = Room.create(name: params["room"]["name"])
  end

end
