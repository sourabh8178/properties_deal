class ContactsController < ApplicationController

	def create
		contact = Contact.new
		contact.name = params[:name]
		contact.email = params[:email]
		contact.subect = params[:subect]
		contact.message = params[:message]
		if contact.save
			flash[:notice] = "Your message has been sent."
			redirect_to "/#contact"
		end
	end
end
