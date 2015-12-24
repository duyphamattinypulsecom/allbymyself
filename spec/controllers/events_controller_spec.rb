require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "GET #index" do
    it "user is redirected to login when haven't login yet" do
      get :index
      expect(response).to have_http_status(302)
    end

    it "renders the index template" do
      session[:user_id] = User.create(name: "a", email: "a", password: "a", password_confirmation: "a").id

      get :index
      expect(response).to render_template("index")
    end

    it "return all user created events into @events, event if the event start time in the past" do
      region = Region.create(name: "Lam Dong")
      category = Category.create(name: "Entertainment")
      venue = Venue.create(name: "venue name", full_address: "venue addr", region: region)
      user = User.create(name: "a", email: "a", password: "a", password_confirmation: "a")
      session[:user_id] = user.id
      event1 = Event.create(creator: user, name: "1 day in future", starts_at: 1.day.from_now, venue: venue, category: category, extended_html_description: "desc")
      event2 = Event.create(creator: user, name: "2 days in future", starts_at: 2.day.from_now, venue: venue, category: category, extended_html_description: "desc")
      event3 = Event.create(creator: user, name: "1 day ago", starts_at: 1.day.ago, venue: venue, category: category, extended_html_description: "desc")

      get :index

      expect(assigns(:events)).to match_array [event1, event2, event3]
    end
    
    it "redirect to /login" do
      expect(get :index).to redirect_to("/login")
    end
  end

  describe "GET #edit" do
    it "user can edit their events" do
      region = Region.create(name: "Lam Dong")
      category = Category.create(name: "Entertainment")
      venue = Venue.create(name: "venue name", full_address: "venue addr", region: region)
      user = User.create(name: "a", email: "a", password: "a", password_confirmation: "a")
      session[:user_id] = user.id
      event1 = Event.create(creator: user, name: "1 day in future", starts_at: 1.day.from_now, venue: venue, category: category, extended_html_description: "desc")

      get :edit, {:id => event1.id}

      expect(response).to render_template("edit")
    end

    it "user can NOT edit other events" do
      region = Region.create(name: "Lam Dong")
      category = Category.create(name: "Entertainment")
      venue = Venue.create(name: "venue name", full_address: "venue addr", region: region)
      user = User.create(name: "a", email: "a", password: "a", password_confirmation: "a")
      session[:user_id] = user.id
      event1 = Event.create(name: "1 day in future", starts_at: 1.day.from_now, venue: venue, category: category, extended_html_description: "desc")

      get :edit, {:id => event1.id}

      expect(response).to render_template("index")
    end
  end
end
