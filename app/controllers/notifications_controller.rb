class NotificationsController < ApplicationController
  def _notification
  end

  def notif_read
    notif = Notification.find_by(id: params[:id])
    notif.update(status: "read")
    redirect_to request.referrer
  end

  def marked_as_read
    notif = Notification.where(id: current_user.notifications.unread.map(&:id))
    notif.update(status: "read")
    redirect_to request.referrer
  end

end
