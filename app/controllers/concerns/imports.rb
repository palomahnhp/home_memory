module Imports
  extend ActiveSupport::Concern

  def import
    filepath = params[:file].tempfile.path
    if File.exist?(filepath)
      message = 'Lanzada tarea de importación. Carga disponible en unos minutos'
      eval(controller_name.camelize + 'Importer').new(File.extname(params[:file].original_filename),
                               filepath).run
    else
      message = 'Error al obtener el fichero de importación.' +
          ' No se ha iniciado el proceso: ' + filepath
    end
    redirect_to analytical_groups_path,notice: message
  end

end