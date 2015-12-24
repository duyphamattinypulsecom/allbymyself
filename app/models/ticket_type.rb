class TicketType < ActiveRecord::Base
  belongs_to :event

  def your_booked_quanlity user_id
    ticket = Ticket.where('user_id = ? and ticket_type_id = ?', user_id, id).first
    ticket ? ticket.quanlity : 0
  end
end
