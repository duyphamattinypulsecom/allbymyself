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
end
