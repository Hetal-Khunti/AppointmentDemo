class Appointment < ApplicationRecord
	belongs_to :doctor, class_name: "User"
	belongs_to :patient, class_name: "User"

	validates :date, :start_time, :end_time, presence: true

	validate :date_validation, on: :create

	def date_validation
		 #patient.patient_appointments.where("date = ? and start_time = ? and end_time = ?")
		 if patient.patient_appointments.where('(date = ? and end_time BETWEEN ? AND ?) or (date = ? and start_time BETWEEN ? AND ?)', self.date, self.start_time, self.end_time, self.date, self.start_time, self.end_time).present?
		 	errors.add(:end_time, "You have another appointment on this time ")
		elsif doctor.doctor_appointments.where('(date = ? and end_time BETWEEN ? AND ?) or (date = ? and start_time BETWEEN ? AND ?)', self.date, self.start_time, self.end_time, self.date, self.start_time, self.end_time).present?
		 	errors.add(:end_time, "Doctor has already appointment on this time ")
		 else
		 	return true
		 end
	end

end
