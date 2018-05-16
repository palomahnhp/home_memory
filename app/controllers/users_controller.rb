class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @search = User.search(params[:q])
    @search.sorts = 'first_name asc' if @search.sorts.empty?
    @users = @search.result.page(params[:page])
    @search.build_condition
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'Creado usuario.'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Usuario actualizado.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'Usuario eliminado'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :born_date,
                                      :document,
                                      properties_attributes: [:id,
                                                          :fieldset,
                                                          :name,
                                                          :value,
                                                          :order,
                                                          :user_id,
                                                          :_destroy],
                                      documents_attributes: [:id,
                                                             :title,
                                                             :attachment,
                                                             :cached_attachment,
                                                             :user_id,
                                                             :_destroy],
                                      )
    end
end
