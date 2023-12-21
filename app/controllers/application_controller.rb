class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  load_and_authorize_resource
  before_action :set_ability
  protect_from_forgery with: :exception
  before_action :update_allowed_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  def set_ability
    @ability ||= Ability.new(current_user)
  end
end
