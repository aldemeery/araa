class UsersController < ApplicationController
  include SessionsHelper

  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_login, except: %w[new create]
  before_action :require_logout, only: %w[new create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show; end

  def new
    @user = User.new
    render 'auth/signup'
  end

  # GET /users/1/edit
  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      login @user
      redirect_to root_path, notice: 'Successful registration.'
    else
      redirect_back fallback_location: signup_path, notice: 'Registration failed.'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
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
