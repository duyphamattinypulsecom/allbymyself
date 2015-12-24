require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe "validation on quantity" do 
        before do
            region = Region.create(name: "Lam Dong")
            category = Category.create(name: "Entertainment")
            venue = Venue.create(name: "venue name", full_address: "venue addr", region: region)
            @event1 = Event.create(name: "1 day in future", starts_at: 1.day.from_now, venue: venue, category: category, extended_html_description: "desc")

            @tickettype = TicketType.create(name: "type 1", max_quantity: 100, price: 100000, event: @event1)

            @user1 = User.create(name: "a", email: "a", password: "a", password_confirmation: "a")
        end

        it "quantity <= 0 will return error" do
            ticket = Ticket.create(user: @user1, event: @event1, ticket_type: @tickettype, quanlity: 0)
            expect(ticket.errors).to match_array ["Quanlity must be greater than 0"]

            ticket = Ticket.create(user: @user1, event: @event1, ticket_type: @tickettype, quanlity: -1)
            expect(ticket.errors).to match_array ["Quanlity must be greater than 0"]
        end

        it "quantity > 0 will return no error" do
            ticket = Ticket.create(user: @user1, event: @event1, ticket_type: @tickettype, quanlity: 10)
            expect(ticket.errors).to match_array []
        end
    end
end
