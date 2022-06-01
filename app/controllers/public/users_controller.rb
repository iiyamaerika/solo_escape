class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  
  def index
     @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @articles = @user.articles
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path
    else
      render :edit
    end
  end
  
  def destroy
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :name_kana, :nickname, :gender, :age, :partner_gender, :partner_age, :partner_type, :personal_comment, :telephone_number, :address, :image)
  end
  
end
