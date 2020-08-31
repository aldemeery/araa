class UsersController < ApplicationController
  include SessionsHelper

  before_action :set_user, only: %i[show edit update destroy follow unfollow]
  before_action :require_login, except: %w[new create]
  before_action :require_logout, only: %w[new create]

  def show
    @user = User.includes(followers: :follower, followings: :followed).find(@user.id)
    @opinions = Opinion.where('user_id in (?)', (
      @user.followers_ids + @user.followings_ids + [@user.id]
    ).uniq)
      .includes(:user)
      .order(created_at: :desc)
  end

  def profile
    @user = User.includes(followers: :follower, followings: :followed).find(logged_user.id)
    @opinions = Opinion.where('user_id in (?)', (
        @user.followers_ids + @user.followings_ids + [@user.id]
      ).uniq)
      .includes(:user)
      .order(created_at: :desc)
    @suggestions = User.where('id NOT IN (?)', @user.followings.map(&:followed_id) + [@user.id])
      .limit(10)
      .order(created_at: :desc)
    render 'users/profile'
  end

  def new
    @user = User.new
    render 'auth/signup', layout: false
  end

  def edit
    redirect_to root_path unless logged_user == @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login @user
      redirect_to root_path, notice: 'Successful registration.'
    else
      redirect_back fallback_location: signup_path, alert: 'Registration failed.'
    end
  end

  def update
    redirect_back fallback_location: root_path unless logged_user == @user

    if @user.update(user_params)
      redirect_to root_path
    else
      redirect_back fallback_location: edit_user_path
    end
  end

  def destroy
    logged_user.destroy
    logout

    redirect_to login_path
  end

  def follow
    logged_user.follow(@user)
    redirect_back fallback_location: root_path
  end

  def unfollow
    logged_user.unfollow(@user)
    redirect_back fallback_location: root_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:full_name, :username, :photo, :cover_image)
  end
end
