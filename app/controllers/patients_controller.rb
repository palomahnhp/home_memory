class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def index
    @search = Patient.search(params[:q])
    @search.sorts = 'first_name asc' if @search.sorts.empty?
    @patients = @search.result.page(params[:page])
    @search.build_condition
  end

  def show; end

  def new
    @patient = Patient.new
  end

  def edit; end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      redirect_to patients_path, notice: 'Pacient was successfully created.'
    else
      render :new
    end
  end

  def update
    if @patient.update(patient_params)
      redirect_to @patient, notice: 'Pacient was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @patient.destroy
    redirect_to patients_url, notice: 'Pacient was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    def patient_params
      params.require(:patient).permit(:first_name, :last_name, :born_date,
                                      :document, :public_health_org,
                                      :public_health_org_url,
                                      :public_health_membership_number,
                                      :public_health_card_number,
                                      :public_health_autonomic_code,
                                      :private_health_company,
                                      :private_health_company_url,
                                      :private_health_card_number,
                                      appointments_attributes: [
                                          :id,
                                          :professional_id,
                                          :_destroy],
                                      documents_attributes: [:id,
                                                             :title,
                                                             :attachment,
                                                             :cached_attachment,
                                                             :user_id,
                                                             :_destroy]
                                      )
    end
end
