class HistoriesController < ApplicationController
  before_action :set_history, only: [:show, :edit, :update, :destroy]
  before_action :set_patient, only: [:show, :edit, :update, :new, :create, :destroy]

  def index
    @patient = Patient.find_by(id: params[:patient_id])

    @search = @patient.histories.search(params[:q])
    @search.sorts = "even_at desc"  if @search.sorts.empty?

    @histories = @search.result
    @search.build_condition

  end

  # GET /histories/1
  # GET /histories/1.json
  def show

  end

  # GET /histories/new
  def new
    @history = History.new
    @history.kind = params[:kind]
  end

  # GET /histories/1/edit
  def edit
  end

  # POST /histories
  # POST /histories.json
  def create
    @history = History.new(history_params)
    if @history.save
      redirect_to @history, notice: 'History was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /histories/1
  # PATCH/PUT /histories/1.json
  def update
    respond_to do |format|
      if @history.update(history_params)
        format.html { redirect_to @history, notice: 'History was successfully updated.' }
        format.json { render :show, status: :ok, location: @history }
      else
        format.html { render :edit }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /histories/1
  # DELETE /histories/1.json
  def destroy
    @history.destroy
    respond_to do |format|
      format.html { redirect_to histories_url, notice: 'History was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history
      @history = History.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def history_params
      params.require(:history).permit(:id, :name, :note, :patient_id,
                                      :professional_id,
                                      :appointment_id,
                                       prescription_attributes: [
                                          :id,
                                          :medicament_id,
                                          :posology,
                                          :inii_at,
                                          :end_at
                                          ]
                                      )
    end

    def set_patient
      @patient = Patient.find_by(id: params[:patient_id])
    end
end
