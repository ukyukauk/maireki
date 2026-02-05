class ShrinesController < ApplicationController
  before_action :set_shrine, only: [:show, :edit, :update]
  before_action :authenticate_user!

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
    if @shrine.update(shrine_params)
      redirect_to shrine_path(@shrine)
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
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
