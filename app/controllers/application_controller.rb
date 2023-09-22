class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	before_action :user_admin, expect:[:after_sign_in_path_for]
  include ApplicationHelper
  layout :set_layout
  def after_sign_in_path_for(resource)
    if resource.role == "admin"
    (resource.role == "admin") ? admin_root_path : root_path
    else
      (resource.profile.present? == false) ? "/profile" : root_path
    end
  end
  def user_admin
    if request.fullpath.split("/")[1] == "admin"
      if current_user.role != 'admin'
        redirect_to root_path
      else
        request.url
      end
    end
  end
  def authentication_admin!
    unless current_user.role == "admin"
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
  end

  def check_profile
    if current_user&.present? && current_user.role != "admin"
      if !current_user&.profile.present? || current_user&.profile&.is_complete == false
        redirect_to(profile_path)
      end
    end
  end

  def check_profile_for_agent
    if current_user&.present? && current_user.role != "agent"
      redirect_to(request.referer)
    end
  end
end
