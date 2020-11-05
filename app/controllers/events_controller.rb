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
    @event.admin = current_user
    puts "$" * 50
    puts @event
    puts params[:start_date]
    puts "$" * 50
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
    post_params = params.require(:event).permit(:title, :location, :description, :start_date, :price, :duration)
  end
end