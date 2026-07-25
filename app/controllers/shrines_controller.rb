class ShrinesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shrine, only: [:show, :edit, :update]

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
      if safe_return_to = safe_internal_path(params[:return_to])
        redirect_to "#{safe_return_to}?shrine_id=#{@shrine.id}", notice: '神社を登録しました'
      else
        redirect_to shrine_path(@shrine), notice: '神社を登録しました'
      end
    else
      flash.now[:error] = '神社の登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @shrine.update(shrine_params)
      redirect_to shrine_path(@shrine), notice: '神社を更新しました'
    else
      flash.now[:error] = '神社の更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    shrine = current_user.shrines.find(params[:id])
    shrine.destroy!
    redirect_to shrines_path, status: :see_other, notice: '神社を削除しました'
  end

  private
  def shrine_params
    params.require(:shrine).permit(:name, :prefecture, :address, :deities, :blessings)
  end

  def set_shrine
    @shrine = current_user.shrines.find(params[:id])
  end

  def safe_internal_path(path)
    return nil if path.blank?
    return nil unless path.start_with?('/') # 外部URL対策
    path
  end
end
