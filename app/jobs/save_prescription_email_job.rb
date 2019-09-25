class SavePrescriptionEmailJob < ApplicationJob
  queue_as :default

  def perform(note)
  	@note = note
    AppointmentMailer.with(note: @note).send_prescription_email.deliver_now
  end
end
