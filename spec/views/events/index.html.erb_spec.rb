require 'rails_helper'

RSpec.describe "events/index", :type => :view do
  it "renders _card partial for each event" do
    region = Region.create(name: "Lam Dong")
    category = Category.create(name: "Entertainment")
    venue = Venue.create(name: "venue name", full_address: "venue addr", region: region)
    user = User.create(name: "a", email: "a", password: "a", password_confirmation: "a")
    event1 = Event.create(creator: user, name: "1 day in future", starts_at: 1.day.from_now, venue: venue, category: category, extended_html_description: "desc")
    event2 = Event.create(creator: user, name: "2 days in future", starts_at: 2.day.from_now, venue: venue, category: category, extended_html_description: "desc")

    assign(:events, [event1, event2])

    render
    
    expect(view).to render_template(:partial => "_card", :count => 2)
  end
end