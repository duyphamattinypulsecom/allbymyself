class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at, :name

  def self.bookable_event(title_contain_str = "")
    bookable = "starts_at >= ? and public = true"
    if title_contain_str 
        Event.where("upper(name) like upper('%#{title_contain_str}%') and #{bookable}", Time.zone.now)
    else
        @events = Event.where(bookable, Time.zone.now)
    end
  end

end
