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

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Profil édité !"
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "Impossible d'éditer le profil :"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :description)
  end
end
