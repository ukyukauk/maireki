class ShrinesController < ApplicationController
  before_action :set_shrine, only: [:show, :edit, :update]
  before_action :authenticate_user!

  def index
    @shrines = current_user.shrines.order(:created_at)
  end

  def show
  end

  def new
    @shrine = current_user.shrines.build
  end

  def create
    @shrine = current_user.shrines.build(shrine_params)
    if @shrine.save
      redirect_to shrine_path(@shrine), notice: '登録しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @shrine.update(shrine_params)
      redirect_to shrine_path(@shrine), notice: '更新しました'
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    shrine = current_user.shrines.find(params[:id])
    shrine.destroy!
    redirect_to shrines_path, status: :see_other, notice: '削除しました'
  end

  private
  def shrine_params
    params.require(:shrine).permit(:name, :prefecture, :address, :deities, :blessings)
  end

  def set_shrine
    @shrine = current_user.shrines.find(params[:id])
  end
end
