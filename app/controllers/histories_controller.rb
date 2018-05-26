class HistoriesController < ApplicationController
  before_action :set_history, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:create]

  def index
    @user = User.find_by(id: params[:user_id])
    if params[:process].present?
      @search = @user.histories.by_process(params[:process]).search(params[:q])
    else
      @search = @user.histories.search(params[:q])
    end
    @search.sorts = "even_at desc"  if @search.sorts.empty?
    @histories = @search.result.order(event_at: :desc)
    @search.build_condition
  end

  def show;  end

  def new
    @history = History.new(kind: params[:kind], user_id: params[:user_id])
  end

  def edit
    @user = @history.user
  end

  def create
    @history = History.new(history_params)

    if @history.save
      params[:history][:process_id] = @history.id if params[:history][:initial_process] == 1
      redirect_to histories_path(user_id: @user), notice: 'History was successfully created.'
    else
      render :new, alert: 'Error creando el registro.'
    end
  end

  def update
    respond_to do |format|
      params[:history][:process_id] = @history.id if params[:history][:initial_process]== 1
      if @history.update(history_params)
        format.html { redirect_to @history, notice: 'History was successfully updated.' }
        format.json { render :show, status: :ok, location: @history }
      else
        format.html { render :edit, alert: @history.errors }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = @history.user
    @history.prescriptions.destroy_all
    @history.delete

    redirect_to histories_path(user_id: @user),
                notice: 'History was successfully destroyed.'
  end

  private
    def set_history
      @history = History.find(params[:id])
    end

    def history_params
      params.require(:history).permit(:id, :event_at, :kind,
                                      :note,
                                      :user_id,
                                      :professional_id,
                                      :speciality_id,
                                      :appointment_id,
                                      :medical_center_id,
                                      :reason,
                                      :location,
                                      :order,
                                      :process_id,
                                      :initial_process,
                                       prescriptions_attributes: [
                                          :id,
                                          :medication_id,
                                          :posology,
                                          :init_at,
                                          :end_at,
                                          :_destroy],
                                       documents_attributes: [:id,
                                                              :title,
                                                              :attachment,
                                                              :cached_attachment,
                                                              :user_id,
                                                              :_destroy],
                                       medical_tests_attributes: [:id,
                                                                  :name,
                                                                  :medical_center_id,
                                                                  :instructions,
                                                                  :report,
                                                                  :performed_at,
                                                                  :performed_in,
                                                                  :_destroy ]
                                      )

    end

    def set_user
      @user = User.find_by(id: params[:history][:user_id])
    end
end
