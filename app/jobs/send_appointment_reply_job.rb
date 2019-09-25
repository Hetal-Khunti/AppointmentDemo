class SendAppointmentReplyJob < ApplicationJob
  queue_as :default

  def perform(appointment)
  	@appointment = appointment
  	
    AppointmentMailer.with(appointment: @appointment).appointment_reply_email.deliver_now
  end
end
