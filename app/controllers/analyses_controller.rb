class AnalysesController < ApplicationController

  before_action :set_analysis, only: [:show, :edit, :update, :destroy]
  Thread.abort_on_exception=true

  # GET /analisies
  # GET /analisies.json
  def index
    @analyses = Analysis.all
  end

  # GET /analisies/1
  # GET /analisies/1.json
  def show
  end

  # GET /analisies/new
  def new
    @analysis = Analysis.new
  end

  # GET /analisies/1/edit
  def edit
  end

  # POST /analisies
  # POST /analisies.json
  def create
    @analysis = Analysis.new(analisy_params)

    respond_to do |format|
      if @analysis.save
        format.html { redirect_to @analysis, notice: 'Analysis was successfully created.' }
        format.json { render :show, status: :created, location: @analisy }
      else
        format.html { render :new }
        format.json { render json: @analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /analisies/1
  # PATCH/PUT /analisies/1.json
  def update
    respond_to do |format|
      if @analysis.update(analisy_params)
        format.html { redirect_to @analysis, notice: 'Analisy was successfully updated.' }
        format.json { render :show, status: :ok, location: @analysis }
      else
        format.html { render :edit }
        format.json { render json: @analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /analisies/1
  # DELETE /analisies/1.json
  def destroy
    @analysis.destroy
    respond_to do |format|
      format.html { redirect_to analyses_url, notice: 'Analisy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    filepath = params[:file].tempfile.path
    if File.exists?(filepath)
      message = 'Lanzada tarea de importación. Carga disponible en unos minutos'
      AnalysisImporter.new(File.extname(params[:file].original_filename), filepath).run
      # begin
      #   t = Thread.new do
      #     Importers::AnalysisImporter.new(File.extname(params[:file].original_filename), filepath).run
      #     ActiveRecord::Base.connection.close
      #   end
      # rescue Exception => e
      #   puts "EXCEPTION: #{e.inspect}"
      #   puts "MESSAGE: #{e.message}"
      # end
    else
      message =  'Error al obtener el fichero de importación. No se ha iniciado el proceso: ' + filepath
    end
    redirect_to analyses_path, notice: message

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_analysis
      @analysis = Analysis.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def analysis_params
      params.fetch(:analysis, {})
    end
end
