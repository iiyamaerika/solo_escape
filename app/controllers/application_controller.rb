class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
      when Admin
        admin_root_path
      when User
        user_path(current_user)
    end
  end

  def after_sign_out_path_for(resource)
    top_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :name_kana, :nickname, :gender, :age, :partner_gender, :partner_age, :partner_type, :personal_comment, :email, :telephone_number, :address, :image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :name_kana, :nickname, :gender, :age, :partner_gender, :partner_age, :partner_type, :personal_comment, :email, :telephone_number, :address, :image])
  end


end
