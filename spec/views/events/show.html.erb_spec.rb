require 'rails_helper'

RSpec.describe "events/show", :type => :view do
  it "renders book now button when user haven't booked this event yet" do
    region = Region.create(name: "Lam Dong")
    category = Category.create(name: "Entertainment")
    venue = Venue.create(name: "venue name", full_address: "venue addr", region: region)
    user = User.create(name: "a", email: "a", password: "a", password_confirmation: "a")
    event1 = Event.create(creator: user, name: "1 day in future", starts_at: 1.day.from_now, venue: venue, category: category, extended_html_description: "desc")
    
    assign(:event, event1)

    render
    
    expect(rendered).to include "book now"
  end

  it "renders booked button when user haven booked this event yet" do
    region = Region.create(name: "Lam Dong")
    category = Category.create(name: "Entertainment")
    venue = Venue.create(name: "venue name", full_address: "venue addr", region: region)
    user = User.create(name: "a", email: "a", password: "a", password_confirmation: "a")
    event1 = Event.create(creator: user, name: "1 day in future", starts_at: 1.day.from_now, venue: venue, category: category, extended_html_description: "desc")
    
    @tickettype1 = TicketType.create(name: "type 1", max_quantity: 100, price: 100000, event: @event1)
    @tickettype2 = TicketType.create(name: "type 2", max_quantity: 200, price: 200000, event: @event1)

    @ticket1 = Ticket.create(user: @user, event: @event1, ticket_type: @tickettype1, quanlity: 10)
    @ticket2 = Ticket.create(user: @user, event: @event1, ticket_type: @tickettype2, quanlity: 10)

    assign(:event, event1)

    render
    
    expect(rendered).to include "booked"
  end
end