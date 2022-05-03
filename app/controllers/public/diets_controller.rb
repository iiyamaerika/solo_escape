class Public::DietsController < ApplicationController

  def index
    # @data = Weight.where(user_id: current_user.id)
    @data = current_user.weights
  end

  def new
    @weight = Weight.new
  end

  def create
    Weight.create(weight_parameter)
    redirect_to diets_path
  end

  def destroy
    @weight = Weight.find(params[:id])
    @weight.destroy
    redirect_to diets_path, notice:"削除しました"
  end

  def edit
    @weight = Weight.find(params[:id])
  end

  def update
    @weight = Weight.find(params[:id])
    if @weight.update(weight_parameter)
      redirect_to diets_path, notice: "編集しました"
    else
      render 'edit'
    end
  end

  private

  def weight_parameter
    params.require(:weight).permit(:date, :weight, :user_id)
  end

end
