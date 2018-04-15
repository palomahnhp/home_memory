class MedicalTestsController < ApplicationController

  before_action :set_medical_test, only: [:show, :edit, :update, :destroy]
  Thread.abort_on_exception=true

  # GET /analisies
  # GET /analisies.json
  def index
    if params[:id]
      @search = MedicalTest.by_patient(params[:id]).search(params[:q])
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
  end

  # GET /analisies/1/edit
  def edit
  end

  # POST /analisies
  # POST /analisies.json
  def create
    @medical_test = MedicalTest.new(analisy_params)

    respond_to do |format|
      if @medical_test.save
        format.html { redirect_to @medical_test, notice: 'MedicalTest was successfully created.' }
        format.json { render :show, status: :created, location: @analisy }
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
      if @medical_test.update(analisy_params)
        format.html { redirect_to @medical_test, notice: 'Analisy was successfully updated.' }
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
      format.html { redirect_to medical_tests_url, notice: 'Analisy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    filepath = params[:file].tempfile.path
    if File.exists?(filepath)
      message = 'Lanzada tarea de importación. Carga disponible en unos minutos'
      MedicalTestImporter.new(File.extname(params[:file].original_filename), filepath).run
    else
      message =  'Error al obtener el fichero de importación. No se ha iniciado el proceso: ' + filepath
    end
    redirect_to medical_tests_path, notice: message

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medical_test
      @medical_test = MedicalTest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def medical_test_params
      params.fetch(:medical_test, {})
    end
end
