class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.text :description
      t.date :date
      t.time :start_time
      t.time :end_time
      t.integer :doctor_id
      t.integer :patient_id
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
