class EventsController < ApplicationController
  def index
    @events = current_user.events
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @venue = Venue.all
    @category = Category.all
  end

  def create
    @event = Event.new(event_params)
    @event.public = false
    @event.creator = current_user
    @event.hero_image_url = 'https://az810747.vo.msecnd.net/eventcover/2015/10/25/C6A1A5.jpg?w=1040&maxheight=400&mode=crop&anchor=topcenter'

    if @event.save 
      redirect_to new_event_tickettype_path(@event)
    else
      @venue = Venue.all
      @category = Category.all
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
    @venue = Venue.all
    @category = Category.all
  end

  def update
    if Event.update(params[:id], event_params)
      redirect_to new_event_tickettype_path(:event_id => params[:id])
    else
      @venue = Venue.all
      @category = Category.all
      render 'edit'
    end
  end

  def publish_event
    event = Event.find(params[:id])
    if event.ticket_types.count > 0
      event.update(public: true)
      redirect_to events_path
    else
      @events = current_user.events
      @error = "Event <strong>#{event.name}</strong> have no ticket type"
      render 'index'
    end
  end

  private 
  def event_params
    params.require(:event).permit(:name, :hero_image_url, :category_id, :venue_id, :starts_at, :ends_at, :extended_html_description)
  end
end
