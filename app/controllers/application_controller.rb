class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :load_current_user
  # before_filter :login_required
  after_filter :set_csrf_cookie_for_angular

  def set_csrf_cookie_for_angular
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

protected

  def current_user
    @current_user
  end
  helper_method :current_user

  def logged_in?
    !!(current_user && !current_user.guest?)
  end
  helper_method :logged_in?

private

  def load_current_user
    if session[:auth_token]
      @current_user = User.where(auth_token: session[:auth_token]).first
    else
      @current_user = User.create!(guest: true, auth_token: SecureRandom.hex)
      session[:auth_token] = @current_user.auth_token
    end
  end

  def login_required
    logged_in? || redirect_to(login_path, alert: 'You must be logged in to do that')
  end
end
