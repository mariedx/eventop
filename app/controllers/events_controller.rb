class EventsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def new
    @event = Event.new
  end

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(post_params)
    @event.event_admin = current_user

    if @event.save
      redirect_to event_path(@event.id), success: "Evénement créé avec succès !"
    else
      render :new
    end
  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Il faut s'enregistrer bb"
      redirect_to new_user_session_path
    end
  end

  def post_params
    post_params = params.require(:event).permit(:start_date, :title, :duration, :description, :price, :location)
  end
end
