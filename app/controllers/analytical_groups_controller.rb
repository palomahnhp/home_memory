class AnalyticalGroupsController < ApplicationController
  before_action :set_analytical_group, only: [:show, :edit, :update, :destroy ]

  def index
    @groups = AnalyticalGroup.all
  end

  def edit
  end

  def update
   if @group.update(analytical_group_params)
     redirect_to analytical_groups_path, notice: 'Se ha creado el grupo'
   else
     render :new, notice: 'Error al actualizar el grupo ' + @group.errors.messages
   end
  end

  def new
    @group = AnalyticalGroup.new
  end

  def create
    @group = AnalyticalGroup.new(analytical_group_params)
    if @group.save
      redirect_to analytical_groups_path, notice: 'Se ha creado el grupo'
    else
      render :new, notice: 'Error al actualizar el grupo ' + @group.errors.messages
    end
  end

  def destroy
    if @group.analytical_items.empty?
      if @group.destroy
        message =  "Se ha eliminado el grupo"
      end
    else
      message = "No se ha podido eliminar el grupo, no está vacio"
    end
    redirect_to analytical_groups_path, notice: message
  end

  def import
    filepath = params[:file].tempfile.path
    if File.exist?(filepath)
      message = 'Lanzada tarea de importación. Carga disponible en unos minutos'
      AnalyticalGroupsImporter.new(File.extname(params[:file].original_filename),
                              filepath).run
    else
      message =  'Error al obtener el fichero de importación.' +
          ' No se ha iniciado el proceso: ' + filepath
    end
    redirect_to analytical_groups_path,notice: message
  end

  private

  def analytical_group_params
    params.require(:analytical_group).permit(:id, :name, :inactive)
  end

  def set_analytical_group
    @group = AnalyticalGroup.find(params[:id])
  end
end
