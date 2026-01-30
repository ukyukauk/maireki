class VisitsController < ApplicationController
  before_action :set_shrine, only: [:show]
  # before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update, :destroy]

  def index
    @visits = Visit.all
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
      :visited_on, :prayer, :impression,
      items_attributes: [:id, :category, :name, :price, :_destroy]
    )
  end
end
