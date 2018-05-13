class MedicalTestsController < ApplicationController

  before_action :set_medical_test, only: [:show, :edit, :update, :destroy]
  Thread.abort_on_exception=true

  def index
    @user = User.find(params[:user_id])
    if @user
      @search = MedicalTest.by_user(@user).search(params[:q])
    else
      @search  = MedicalTest.search(params[:q])
    end

    @search.sorts = 'performed_at desc' if @search.sorts.empty?
    @medical_tests = @search.result.page(params[:page])
    @search.build_condition
  end

  def show; end

  def new
    @medical_test = MedicalTest.new
    @user = User.find(params[:user_id])
  end

  def edit; end

  def create
    @medical_test = MedicalTest.new(medical_test_params)
    if @medical_test.save
      redirect_to medical_test_path(@medical_test),
                                  notice: 'Prueba creada correctamente.'
    else
        render :new, alert: 'Error creando prueba #{@medical_test.errors.messages}'
    end
  end

  def update
    respond_to do |format|
      if @medical_test.update(medical_test_params)
        format.html { redirect_to @medical_test, notice: 'Prueba actualizada acorrectamente.' }
        format.json { render :show, status: :ok, location: @medical_test }
      else
        format.html { render :edit }
        format.json { render json: @medical_test.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @medical_test.destroy
    respond_to do |format|
      format.html { redirect_to medical_tests_path(user_id: params[:user_id]),
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
    redirect_to medical_tests_path(user_id: params[:user_id]),
                notice: message
  end

  private
    def set_medical_test
      @medical_test = MedicalTest.includes(:analysis_results).find(params[:id])
    end

    def medical_test_params
      params.require(:medical_test).
          permit(:history_id,
                 :professional_id,
                 :name,
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
