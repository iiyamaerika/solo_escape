class Public::DietsController < ApplicationController

  def index
    @weight = Weight.new
    @user_weights = current_user.weight
  end


end
