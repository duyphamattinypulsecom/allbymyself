class TickettypesController < ApplicationController
  def new
      @event = Event.find(params[:event_id])
  end

  def create
    @event = Event.find(params[:event_id])
    @tickettype = TicketType.new(tickettype_params)

    if @tickettype.save
      @event.ticket_types << @tickettype
      redirect_to new_event_tickettype_path
    else
      render 'new'
    end
  end

  def update

  end

  def destroy
      TicketType.delete(params[:id])
      redirect_to new_event_tickettype_path
  end

  private
  def tickettype_params
      params.require(:ticket_type).permit(:name, :price, :max_quantity)
  end
end
