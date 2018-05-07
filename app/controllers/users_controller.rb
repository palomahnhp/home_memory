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
      redirect_to users_path, notice: 'Pacient was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Pacient was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'Pacient was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :born_date,
                                      :document, :public_health_org,
                                      :public_health_org_url,
                                      :public_health_membership_number,
                                      :public_health_card_number,
                                      :public_health_autonomic_code,
                                      :private_health_company,
                                      :private_health_company_url,
                                      :private_health_card_number,
                                      appointments_attributes: [
                                          :id,
                                          :professional_id,
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
