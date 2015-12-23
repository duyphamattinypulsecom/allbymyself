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
      @event = Event.new(event_params)
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

  private 
  def event_params
    params.require(:event).permit(:name, :hero_image_url, :category_id, :venue_id, :starts_at, :ends_at, :extended_html_description)
  end
end
