class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @events = Event.where(admin: @user)
  end

  def edit
    @user = current_user
  end

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end
end
