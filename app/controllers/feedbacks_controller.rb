class FeedbacksController < ApplicationController
  def create
    @feedback = current_user.feedbacks.create(property_id: params[:property_id], name: params[:feedback][:name], email: params[:feedback][:email], message: params[:feedback][:message])
  end


end
