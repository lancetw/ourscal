class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def new
    @event = Event.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def date
    @events = Event.where('start_time BETWEEN ? AND ?', params[:date].to_datetime.beginning_of_day, params[:date].to_datetime.end_of_day).all

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to root_path

    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :start_time)
  end
end
