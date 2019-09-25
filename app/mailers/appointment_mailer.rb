class AppointmentMailer < ApplicationMailer

	def new_appointment_email
    @appointment = params[:appointment]

    mail(to: @appointment.doctor.email,  subject: "New Appointment!")
  end

  def appointment_reply_email
    @appointment = params[:appointment]

    mail(to: @appointment.patient.email,  subject: "Appointment Reply")
  end

  def send_prescription_email
    @note = params[:note]
    @appointment = @note.appointment

    mail(to: @note.appointment.patient.email,  subject: "Prescription Appointment!")
  end

end
