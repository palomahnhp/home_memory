class HistoriesController < ApplicationController
  before_action :set_history, only: [:show, :edit, :update, :destroy]
  before_action :set_patient, only: [:create, :destroy]

  def index
    @patient = Patient.find_by(id: params[:patient_id])
    @search = @patient.histories.search(params[:q])
    @search.sorts = "even_at desc"  if @search.sorts.empty?
    @histories = @search.result.order(event_at: :desc)
    @search.build_condition
  end

  def show

  end

  def new
    @history = History.new
    @history.kind = params[:kind]
    @patient = Patient.find_by(id: params[:patient_id])
  end

  def edit
    @patient = @history.patient
  end

  def create
    @history = History.new(history_params)

    if @history.save
      redirect_to histories_path(patient_id: @patient), notice: 'History was successfully created.'
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @history.update(history_params)
        format.html { redirect_to @history, notice: 'History was successfully updated.' }
        format.json { render :show, status: :ok, location: @history }
      else
        format.html { render :edit, alert: @history.errors }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @history.destroy
    respond_to do |format|
      format.html { redirect_to histories_url, notice: 'History was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_history
      @history = History.find(params[:id])
    end

    def history_params
      params.require(:history).permit(:id, :event_at, :kind,
                                      :note,
                                      :patient_id,
                                      :professional_id,
                                      :appointment_id,
                                      :medical_center_id,
                                      :reason,
                                      :location,
                                      :order,
                                       prescriptions_attributes: [
                                          :id,
                                          :medication_id,
                                          :posology,
                                          :init_at,
                                          :end_at,
                                          :_destroy],
                                       documents_attributes: [:id,
                                                              :title,
                                                              :attachment,
                                                              :cached_attachment,
                                                              :user_id,
                                                              :_destroy],
                                       medical_tests_attributes: [:id,
                                                                  :name,
                                                                  :medical_center_id,
                                                                  :instructions,
                                                                  :report,
                                                                  :performed_at,
                                                                  :performed_in,
                                                                  :_destroy ]
                                      )

    end

    def set_patient
      @patient = Patient.find_by(id: params[:history][:patient_id])
    end
end
