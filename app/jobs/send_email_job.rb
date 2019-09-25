class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(appointment)
  	@appointment = appointment
  	AppointmentMailer.with(appointment: @appointment).new_appointment_email.deliver_now
  end
end
