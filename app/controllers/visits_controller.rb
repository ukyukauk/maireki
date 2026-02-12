class VisitsController < ApplicationController
  before_action :set_visit, only: [:show]
  before_action :authenticate_user!

  def index
    @visits = current_user.visits.includes(:shrine).order(visited_on: :desc)
  end

  def show
  end

  def new
    @visit = current_user.visits.build
    @visit.items.build
  end

  def create
    @visit = current_user.visits.build(visit_params)

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def set_visit
    @visit = Visit.find(params[:id])
  end

  def visit_params
    params.require(:visit).permit(
      :visited_on, :prayer, :impression, :image,
      items_attributes: [:id, :category, :name, :price, :_destroy]
    )
  end
end
