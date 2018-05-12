class MedicalCentersController < ApplicationController
  before_action :set_medical_center, only: [:show, :edit, :update, :destroy]

  # GET /medical_centers
  # GET /medical_centers.json
  def index
    @search  = MedicalCenter.search(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @medical_centers = @search.result.page(params[:page])
    @search.build_condition
  end

  # GET /medical_centers/1
  # GET /medical_centers/1.json
  def show
  end

  # GET /medical_centers/new
  def new
    @medical_center = MedicalCenter.new
  end

  # GET /medical_centers/1/edit
  def edit
  end

  # POST /medical_centers
  # POST /medical_centers.json
  def create
    @medical_center = MedicalCenter.new(medical_center_params)

    respond_to do |format|
      if @medical_center.save
        format.html { redirect_to @medical_center, notice: 'Registro creado.' }
        format.json { render :show, status: :created, location: @medical_center }
      else
        format.html { render :new }
        format.json { render json: @medical_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medical_centers/1
  # PATCH/PUT /medical_centers/1.json
  def update
    respond_to do |format|
      if @medical_center.update(medical_center_params)
        format.html { redirect_to @medical_center, notice: 'Registro actualizado.' }
        format.json { render :show, status: :ok, location: @medical_center }
      else
        format.html { render :edit }
        format.json { render json: @medical_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medical_centers/1
  # DELETE /medical_centers/1.json
  def destroy
    @medical_center.destroy
    respond_to do |format|
      format.html { redirect_to medical_centers_url, notice: 'Seha eliminado el registro.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medical_center
      @medical_center = MedicalCenter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def medical_center_params
      params.require(:medical_center).permit(:name,
                                             :address,
                                             :kind,
                                             :web,
                                             :email,
                                             :main_phone,
                                             :phone,
                                             :notes)
    end
end
