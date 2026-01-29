class ShrinesController < ApplicationController
  before_action :set_shrine, only: [:show]
  # before_action :authenticate_user!, only: [:show]

  def index
    @shrines = Shrine.all
  end

  def show

  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def set_shrine
    @shrine = Shrine.find(params[:id])
  end
end
