class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :role

  has_many :doctor_appointments, class_name: 'Appointment', :foreign_key => :doctor_id
  has_many :patient_appointments, class_name: 'Appointment', :foreign_key => :patient_id

  scope :doctors, -> { joins(:role).where('roles.name = ?', "Doctor") }

  def full_name
  	[first_name, last_name].join(" ")
  end
  
end
