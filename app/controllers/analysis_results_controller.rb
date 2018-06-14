class AnalysisResultsController < ApplicationController

  def index
    @medical_test = MedicalTest.find_by(id: params[:medical_test])
    @results = AnalysisResult.where(medical_test: @medical_test)
  end

  def edit
    @result = AnalysisResult.find(params[:id])
  end

  def update
    if @result.update(analysis_result_params)
      redirect_to medical_tests_path(@result), notice: 'Actualizado resultado'
    else
      render :edit
    end
  end

  def show
    @result = AnalysisResult.find(params[:id])
  end

  def new
    @result = AnalysisResult.new
  end

  def create
    @result = AnalysisResult.new(analysis_result_params)
    if @result.save(analysis_result_params)
      redirect_to medical_tests_path(@result), notice: 'Creado resultado'
    else
      render :edit
    end
  end

  def destroy
    @result = AnalysisResult.find(params[:id])
    medical_test_id = @result.medical_test

    if @result.destroy
      redirect_to medical_test_path(medical_test_id), notice: 'Eliminado resultado'
    else
      render :index, notice: 'Error eliminando resultado'
    end
  end

  private

  def analysis_result_params
    params.require(:analysis_result).permit(:medical_test_id,
                                            :analytical_item_id,
                                            :amount,
                                            :unit,
                                            :levl,
                                            :grade,
                                            :interpretation)
  end
end
