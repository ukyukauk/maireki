class VisitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_visit, only: [:show, :edit, :update]

  def index
    @visits = current_user.visits.includes(:shrine).order(visited_on: :desc)
  end

  def show
  end

  def new
    @visit = current_user.visits.build
    @visit.shrine_id = params[:shrine_id] if params[:shrine_id].present?

    @visit.items.build if @visit.items.empty?
  end

  def create
    @visit = current_user.visits.build(visit_params)
    if @visit.save
      redirect_to visit_path(@visit), notice: '参拝記録を登録しました'
    else
      @visit.items.build if @visit.items.empty?
      flash.now[:error] = '参拝記録の登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @visit.update(visit_params)
      redirect_to visit_path(@visit), notice: '参拝記録を更新しました'
    else
      flash.now[:error] = '参拝記録の更新に失敗しました。'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    visit = current_user.visits.find(params[:id])
    visit.destroy!
    redirect_to visits_path, status: :see_other, notice:'参拝記録を削除しました'
  end

  private
  def set_visit
    @visit = current_user.visits.find(params[:id])
  end

  def visit_params
    params.require(:visit).permit(
      :visited_on, :shrine_id, :prayer, :impression, :image,
      items_attributes: [:id, :category, :name, :price, :_destroy]
    )
  end
end
