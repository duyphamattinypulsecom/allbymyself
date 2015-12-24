class TicketsController < ApplicationController
  before_action :require_login, only: [:create]

  def index
    @events = current_user.booked_events
  end

  def new
    @event = Event.find(params[:event_id])
  end

  def create
      ids = ticket_params
      ids.each do |i|
        if i[1].to_i > 0
          ticket = Ticket.new(quanlity: i[1].to_i, user_id: current_user.id, event_id: params[:event_id], ticket_type_id: i[0].to_i)
          if ticket.save
            tickettype = TicketType.find(i[0].to_i)
            tickettype.update(max_quantity: tickettype.max_quantity - i[1].to_i)
          else
          end
        end
      end
      redirect_to event_path(:id => params[:event_id])
  end

  def ticket_params
      params.require(:ticket_type_id)
  end
end
