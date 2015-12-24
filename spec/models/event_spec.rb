require 'rails_helper'

RSpec.describe Event, type: :model do

    describe ".bookable_event" do 
        before do
            region = Region.create(name: "Lam Dong")
            category = Category.create(name: "Entertainment")
            venue = Venue.create(name: "venue name", full_address: "venue addr", region: region)
            @event1 = Event.create(name: "1 day in future", starts_at: 1.day.from_now, venue: venue, category: category, extended_html_description: "desc")
            @event2 = Event.create(name: "2 days in future", starts_at: 2.day.from_now, venue: venue, category: category, extended_html_description: "desc")
            @event3 = Event.create(name: "1 day ago", starts_at: 1.day.ago, venue: venue, category: category, extended_html_description: "desc")
        end

        it "all valid future start datetime posts are returned when search by title is empty" do
            events = Event.bookable_event 
            expect(events).to match_array [@event1, @event2]
        end

        it "valid events are returned when search by title is given" do
            events = Event.bookable_event "1"
            expect(events).to match_array [@event1]

            events = Event.bookable_event "in"
            expect(events).to match_array [@event1, @event2]
        end
    end

    describe "#booked" do 
        before do
            region = Region.create(name: "Lam Dong")
            category = Category.create(name: "Entertainment")
            venue = Venue.create(name: "venue name", full_address: "venue addr", region: region)
            @event1 = Event.create(name: "1 day in future", starts_at: 1.day.from_now, venue: venue, category: category, extended_html_description: "desc")
            @event2 = Event.create(name: "2 days in future", starts_at: 2.day.from_now, venue: venue, category: category, extended_html_description: "desc")
            @event3 = Event.create(name: "1 day ago", starts_at: 1.day.ago, venue: venue, category: category, extended_html_description: "desc")

            @tickettype = TicketType.create(name: "type 1", max_quantity: 100, price: 100000, event: @event1)

            @user1 = User.create(name: "a", email: "a", password: "a", password_confirmation: "a")
            @user2 = User.create(name: "b", email: "b", password: "b", password_confirmation: "b")

            @ticket = Ticket.create(user: @user1, event: @event1, ticket_type: @tickettype, quanlity: 10)
        end

        it "event is booked when there is at least 1 ticket created" do
            booked = @event1.booked @user1.id
            expect(booked).to eq true
        end

        it "event is NOT booked when there is NO ticket created" do
            expect(@event2.booked @user1.id).to eq false
            expect(@event1.booked @user2.id).to eq false
        end
    end

    describe "#booked_tickets" do 
        before do
            region = Region.create(name: "Lam Dong")
            category = Category.create(name: "Entertainment")
            venue = Venue.create(name: "venue name", full_address: "venue addr", region: region)
            @event1 = Event.create(name: "1 day in future", starts_at: 1.day.from_now, venue: venue, category: category, extended_html_description: "desc")
            @event2 = Event.create(name: "2 days in future", starts_at: 2.day.from_now, venue: venue, category: category, extended_html_description: "desc")
            @event3 = Event.create(name: "1 day ago", starts_at: 1.day.ago, venue: venue, category: category, extended_html_description: "desc")

            @tickettype1 = TicketType.create(name: "type 1", max_quantity: 100, price: 100000, event: @event1)
            @tickettype2 = TicketType.create(name: "type 2", max_quantity: 200, price: 200000, event: @event1)

            @user1 = User.create(name: "a", email: "a", password: "a", password_confirmation: "a")
            @user2 = User.create(name: "b", email: "b", password: "b", password_confirmation: "b")

            @ticket1 = Ticket.create(user: @user1, event: @event1, ticket_type: @tickettype1, quanlity: 10)
            @ticket2 = Ticket.create(user: @user1, event: @event1, ticket_type: @tickettype2, quanlity: 10)
        end

        it "list of ticket is returned for given user id" do
            expect(@event1.booked_tickets @user1.id).to match_array [@ticket1, @ticket2]
        end
        
        it "empty ticket list is returned when there is no ticket for user" do
            expect(@event1.booked_tickets @user2.id).to match_array []
            expect(@event2.booked_tickets @user1.id).to match_array []
        end

    end
end
