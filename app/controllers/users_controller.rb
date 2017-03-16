class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  def show

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit!)

    if @user.save
      session[:user_id] = @user.id
      flash['notice'] = "You have successfully registered!"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(params.require(:user).permit!)
      flash['notice'] = "Your profile has been updated!"
      redirect_to user_path(@user)
    else
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash['error'] = "You're not allowed to do that"
      redirect_to root_path
    end
  end
end
