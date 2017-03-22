class SessionsController < ApplicationController
  before_action :require_first_auth, only: [:pin]

  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        user.save_pin(generate_pin)
        session[:username] = user.username
        user.send_pin_to_twilio
        redirect_to pin_path
      else
        login_user(user)
      end
    else
      flash['error'] = "There is something wrong with your username or password."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out."
    redirect_to root_path
  end

  def pin
    if (request.post?)
      user = User.find_by(pin: params[:pin])
      if (user && user.username == session[:username])
        session[:username] = nil
        user.remove_pin
        login_user(user)
      else
        flash['error'] = "Sorry, the PIN you entered is incorrect"
      end
    end
  end

  private

  def login_user(user)
    session[:user_id] = user.id
    flash['notice'] = "Welcome!"
    redirect_to root_path
  end

  def generate_pin
    pin = rand(10 ** 6)
    user = User.find_by(pin: pin)

    if (user)
      generate_pin
    else
      return pin
    end
  end

  def require_first_auth
    if (!session[:username])
      flash['error'] = "You can't do that"
      redirect_to posts_path
    end
  end
end
