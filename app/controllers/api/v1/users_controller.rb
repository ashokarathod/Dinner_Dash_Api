class Api::V1::UsersController < ApplicationController

  before_action :find_user, only: [:show, :update, :destroy]
  
  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render error: {error: "Unable to create user"}, status: 400
    end
  end

  def update
    if @user
      @user.update(user_params)
        render json: {message: "user successfully updated"}, status: 200
    else
      render json: {error: "unable to update user.."}, status: 400
    end
  end

  def destroy
    if @user 
      @user.destroy
        render json: {message: "successfully deleted"}, status: 200
    else
      render json: {error: "unable to delete user"}, status: 400
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email)
  end

end
