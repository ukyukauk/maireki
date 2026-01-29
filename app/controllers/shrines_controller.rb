class ShrinesController < ApplicationController
  before_action :set_shrine, only: [:show]
  # before_action :authentication_user!, only: [:show]

  def index
    @shrines = Shrine.all
  end

  def show

  end

  private
  def set_shrine
    @shrine = Shrine.find(params[:id])
  end
end
