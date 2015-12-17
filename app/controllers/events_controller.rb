class EventsController < ApplicationController
  def index
    @events = Event.bookable_event params[:search]
  end

  def show
    @event = Event.find(params[:id])
  end
end
