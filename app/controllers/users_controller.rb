class UsersController < ApplicationController
  skip_before_filter :login_required, only: [ :new, :create ]

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge(auth_token: SecureRandom.hex))
    if @user.save
      session[:auth_token] = @user.auth_token
      redirect_to comps_path, notice: 'Thanks for signing up!'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
