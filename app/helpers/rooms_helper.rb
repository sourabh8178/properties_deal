module RoomsHelper

	def chat_room
		agent_id = []
		ids = User.agents.map(&:id)
		# rooms = Room.where(user_id: current_user.id, sender_id: ids)
		ids.each do |id|
			room = Room.where(user_id: current_user.id, sender_id: id) || Room.where(user_id: id, sender_id: current_user.id)
			if !room.present?
				agent_id << id
			end
		end
		# debugger
		user = User.where(id: agent_id)
		return user.last
	end

	def profile_details(id)
		user = User.find_by(id: id)
		return user
	end
end
