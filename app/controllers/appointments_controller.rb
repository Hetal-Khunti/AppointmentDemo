class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy, :send_prescription, :update_status]

  before_action :authenticate_user!, except: :update_status

  

  
  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = current_user.doctor_appointments
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @doctor = User.find(params[:id])
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        SendEmailJob.set(wait: 15.minutes).perform_later(@appointment)
        format.html { redirect_to root_path, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        @doctor = User.find(appointment_params[:doctor_id])
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_status
    if @appointment.present?
      @appointment.update(status: params[:status])
      SendAppointmentReplyJob.set(wait: 15.minutes).perform_later(@appointment)
      
      if request.xhr?
        render :json => {:status => @appointment.status }
      else
        redirect_to root_path,  notice: 'Appointment was successfully updated.'
      end
    else
      redirect_to root_path
    end
  end

  def send_prescription
    @note = Note.new
  end

  def save_prescription
    @note = Note.new(note_params)
    @note.save
    SavePrescriptionEmailJob.set(wait: 15.minutes).perform_later(@note)
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      if params[:appointment_id]
        @appointment = Appointment.find(params[:appointment_id])
      else
        @appointment = Appointment.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:description, :date, :start_time, :end_time, :doctor_id, :patient_id, :status)
    end

    def note_params
      params.require(:note).permit(:description, :appointment_id, :doctor_id, :patient_id)
    end
end
