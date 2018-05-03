class MedicalTestsController < ApplicationController

  before_action :set_medical_test, only: [:show, :edit, :update, :destroy]
  Thread.abort_on_exception=true

  # GET /analisies
  # GET /analisies.json
  def index
    @patient = Patient.find(params[:patient_id])
    if @patient
      @search = MedicalTest.by_patient(@patient).search(params[:q])
    else
      @search  = MedicalTest.search(params[:q])
    end

    @search.sorts = 'performed_at desc' if @search.sorts.empty?
    @medical_tests = @search.result.page(params[:page])
    @search.build_condition
  end

  # GET /analisies/1
  # GET /analisies/1.json
  def show

  end

  # GET /analisies/new
  def new
    @medical_test = MedicalTest.new
    @patient = Patient.find(params[:patient_id])
  end

  # GET /analisies/1/edit
  def edit
    @patient = @medical_test.patient
  end

  # POST /analisies
  # POST /analisies.json
  def create
    @medical_test = MedicalTest.new(medical_test_params)
    respond_to do |format|
      if @medical_test.save
        format.html { redirect_to medical_test_path(@medical_test),
                                  notice: 'MedicalTest was successfully created.' }
        format.json { render :show, status: :created, location: @medical_test }
      else
        format.html { render :new }
        format.json { render json: @medical_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /analisies/1
  # PATCH/PUT /analisies/1.json
  def update
    respond_to do |format|
      if @medical_test.update(medical_test_params)
        format.html { redirect_to @medical_test, notice: 'Test was successfully updated.' }
        format.json { render :show, status: :ok, location: @medical_test }
      else
        format.html { render :edit }
        format.json { render json: @medical_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /analisies/1
  # DELETE /analisies/1.json
  def destroy
    @medical_test.destroy
    respond_to do |format|
      format.html { redirect_to medical_tests_path(patient_id: params[:patient_id]),
                                notice: 'Prueba eliminada.' }
      format.json { head :no_content }
    end
  end

  def import
    filepath = params[:file].tempfile.path
    if File.exist?(filepath)
      message = 'Lanzada tarea de importación. Carga disponible en unos minutos'
      MedicalTestImporter.new(File.extname(params[:file].original_filename),
                              filepath).run
    else
      message =  'Error al obtener el fichero de importación.' +
          ' No se ha iniciado el proceso: ' + filepath
    end
    redirect_to medical_tests_path(patient_id: params[:patient_id]),
                notice: message

  end

  private
    def set_medical_test
      @medical_test = MedicalTest.find(params[:id])
    end

    def medical_test_params
      params.require(:medical_test).
          permit(:patient_id,
                 :professional_id,
                 :name,
                 :kind,
                 :performed_at,
                 :performed_in,
                 :instructions,
                 :report,
                 :medical_center_id,
                 analysis_results_attributes: [:id,
                                               :analytical_item_id,
                                               :amount,
                                               :unit,
                                               :level,
                                               :grade,
                                               :interpretation,
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
