module HomeHelper
	def property_user(id)
		user = User.find(id)
		return user.profile.name.capitalize
	end
	def convert_time(time)
		utc_time = Time.parse(time.to_s)
		time_zone = ActiveSupport::TimeZone.new("Eastern Time (US & Canada)")
    local_time = utc_time.in_time_zone(time_zone)
    return local_time.strftime("%B %d, %Y")
	end
end
