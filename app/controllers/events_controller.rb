class EventsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(post_params)
    @event.admin = current_user
    if @event.save
      redirect_to event_path(@event.id), success: "Evénement créé avec succès !"
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(post_params)
      redirect_to event_path(@event.id)
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path
  end

  def event
    @event = Event.find_by(id: params[:event_id])
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