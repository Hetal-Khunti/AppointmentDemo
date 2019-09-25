class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.text :description
      t.integer :appointment_id
      t.integer :doctor_id
      t.integer :patient_id

      t.timestamps
    end
  end
end
