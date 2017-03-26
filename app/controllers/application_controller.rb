class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #  i18n
  before_action :set_locale

  #  Devise - authentication
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Pundit - authorisation
  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  def configure_permitted_parameters # Devise
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email])
  end

  def default_url_options # i18n
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  private

  def skip_pundit? #  Pundit
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def set_locale #  i18n
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
