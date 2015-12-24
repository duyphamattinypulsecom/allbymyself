require 'rails_helper'

RSpec.describe "routing to sign_up", :type => :routing do
  it "routes /tickettypes/:id/remove to tickettypes#destroy" do
    expect(:get => "/tickettypes/1/remove").to route_to(
      :controller => "tickettypes",
      :action => "destroy",
      :id => "1"
    )
  end
  
  it "routes /events/:id/publish to events#publish_event" do
    expect(:get => "/events/1/publish").to route_to(
      :controller => "events",
      :action => "publish_event",
      :id => "1"
    )
  end
end