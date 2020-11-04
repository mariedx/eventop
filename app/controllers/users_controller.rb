class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def destroy
  end
end
