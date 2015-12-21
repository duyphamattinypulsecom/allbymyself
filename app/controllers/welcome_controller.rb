class WelcomeController < ApplicationController
  def index
    @events = Event.bookable_event params[:search]
  end
end
