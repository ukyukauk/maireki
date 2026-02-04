class ShrinesController < ApplicationController
  before_action :set_shrine, only: [:show]
  # before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update, :destroy]

  def index
    @shrines = Shrine.all
  end

  def show

  end

  def new
    @shrine = Shrine.new
  end

  def create
    @shrine = Shrine.new(shrine_params)
    if @shrine.save
      redirect_to shrine_path(@shrine)
    else
      flash.now[:error] = '保存に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def shrine_params
    params.require(:shrine).permit(:name, :prefecture, :address, :deities, :blessings)
  end

  def set_shrine
    @shrine = Shrine.find(params[:id])
  end
end
