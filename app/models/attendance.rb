class Attendance < ApplicationRecord
  after_create :attendance_send

  belongs_to :event
  belongs_to :user

  def attendance_send
    event = self.event
    admin = event.admin
    UserMailer.attendance_email(admin, event).deliver_now
  end
end
