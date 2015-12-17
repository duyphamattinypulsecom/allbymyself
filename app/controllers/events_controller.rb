class EventsController < ApplicationController
  def index
    if params[:search]
        @events = Event.where("upper(name) like upper('%#{params[:search]}%')")
    else
        @events = Event.all
    end

  end

  def show
    @event = Event.find(params[:id])
  end
end
