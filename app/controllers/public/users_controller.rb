class Public::UsersController < ApplicationController
  
  def index
    @events = Event.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :name_kana, :nickname, :gender, :age, :partner_gender, :partner_age, :partner_type, :personal_comment, :telephone_number, :address, :image)
  end
  
end
