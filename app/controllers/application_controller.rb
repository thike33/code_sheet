class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :danger

  protected

  def configure_permitted_parameters
    # サインアップ時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    # アカウント編集時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar avatar_cache])
  end
end
