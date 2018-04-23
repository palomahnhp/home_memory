class AnalyticalItemsController < ApplicationController
  before_action :set_analytical_item, only: [:edit, :show, :destroy]

  def index
    if params[:group].present?
      @group = AnalyticalGroup.find(params[:group])
      @items = AnalyticalItem.where(analytical_group: @group)
    else
      @items = AnalyticalItem.all
    end
  end

  def show
  end

  def new
    @item = AnalyticalItem.new
  end

  def create
    @item = AnalyticalItem.new(analytical_item_params)
    if @item.save
      message =  "Se ha creado el item"
    else
      message =  "Error al crear el item"
      render :new, notice: message
    end
    redirect_to analytical_item_path(@item)
  end

  def edit
  end

  def update
    if @item.update(analytical_item_params)
      message =  "Se ha modificado el item"
    else
      message =  "Error al modificar el item"
      render :edit, notice: message
    end
    redirect_to analytical_item_path(@item)
  end

  def destroy
    if @item.destroy
      message =  "Se ha eliminado el item"
    else
      message =  "Error al eliminar el item"
    end
    redirect_to analytical_items_path, notice: message
  end

  private

  def analytical_item_params
    params.require(:analytical_item).permit(:id, :name, :analytical_group_id,
                                            :analytical_subgroup_id,
                                            :unit, :max_range, :min_range,
                                            :inactive)
  end

  def set_analytical_item
    @item = AnalyticalItem.find(params[:id])
  end
end
