class EventsController < ApplicationController
  def index
    @events = Event.where('creator_id = ?', session[:user_id])
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @venue = Venue.all
    @category = Category.all
  end

  def create
      region = Region.create(name: "Lam Dong")
      category = Category.create(name: "Entertainment")
      venue = Venue.create(name: "venue name", full_address: "venue addr", region: region)

      @event = Event.new(event_params)
      @event.venue = venue
      @event.category = category
      @event.creator = current_user

      if @event.save 

        redirect_to events_path
      else
        render 'new'
      end

  end

  private 
  def event_params
    params.require(:event).permit(:name, :hero_image_url, :starts_at, :ends_at, :extended_html_description)
  end
end
