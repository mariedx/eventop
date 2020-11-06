class AttendancesController < ApplicationController
  before_action :event, only: [:index, :create, :new]
  before_action :authenticate_user!

  def index
    @attendances = @event.attendances
  end

  def new
    @attendance = Attendance.new
  end

  def create

    @amount = @event.amount
    begin
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })
    
    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Paiement participation évènement',
      currency: 'eur',
      })
      
      new_a = Attendance.new(event: @event, stripe_customer_id: customer.id)
      puts "$" * 50
      puts current_user.id
      puts new_a
      puts "$" * 50
      new_a.user_id = current_user.id
      new_a.save

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_attendance_path
    end
  end

  def event
    @event = Event.find_by(id: params[:event_id])
  end

end