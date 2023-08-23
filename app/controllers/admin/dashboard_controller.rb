class Admin::DashboardController < ApplicationController
  layout 'admin'
  before_action :authentication_admin!
  def index
    @properties = Property.all
  end
end
