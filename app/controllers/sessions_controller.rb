class SessionsController < ApplicationController
  skip_before_filter :login_required, except: [ :destroy ]

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      user.update_attribute(:auth_token, SecureRandom.hex)
      session[:auth_token] = user.auth_token
      redirect_to comps_path
    else
      flash.now[:alert] = 'Invalid username or password'
      render :new
    end
  end

  def destroy
    session.delete(:auth_token)
    redirect_to root_url
  end
end
