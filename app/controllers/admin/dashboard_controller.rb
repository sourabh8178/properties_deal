class Admin::DashboardController < ApplicationController
  layout 'admin'
  before_action :authentication_admin!
  def index
    @properties = Property.all.paginate(:page => params[:page], :per_page => 10)
  end
end
