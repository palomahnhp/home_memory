class AnalyticalSubGroupsController < ApplicationController
  before_action :set_analytical_subgroup, only: [:show, :edit, :update, :destroy ]

  def index
    @subgroups = AnalyticalSubGroup.all
  end

  def edit
  end

  def update
   if @subgroup.update(analytical_subgroup_params)
     redirect_to analytical_subgroups_path, notice: 'Se ha creado el grupo'
   else
     render :new, notice: 'Error al actualizar el grupo ' + @subgroup.errors.messages
   end
  end

  def new
    @subgroup = AnalyticalSubGroup.new
  end

  def create
    @subgroup = AnalyticalSubGroup.new(analytical_subgroup_params)
    if @subgroup.save
      redirect_to analytical_subgroups_path, notice: 'Se ha creado el grupo'
    else
      render :new, notice: 'Error al actualizar el grupo ' + @subgroup.errors.messages
    end
  end

  def destroy
    if @subgroup.analytical_group.analytical_items.empty?
      if @subgroup.destroy
        message =  "Se ha eliminado el grupo"
      end
    else
      message = "No se ha podido eliminar el grupo, no está vacio"
    end
    redirect_to analytical_subgroups_path, notice: message
  end

  private

  def analytical_subgroup_params
    params.require(:analytical_subgroup).permit(:id, :analytical_group_id, :name)
  end

  def set_analytical_subgroup
    @subgroup = AnalyticalSubGroup.find(params[:id])
  end
end
