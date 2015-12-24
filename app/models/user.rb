class User < ActiveRecord::Base
    has_secure_password
    has_many :venues, class_name: "Venue", foreign_key: "user_id"
    has_many :events, class_name: "Event", foreign_key: "creator_id"

    validates :email, :name, presence: true
    validates_confirmation_of :password

    def booked_events
      Event.where("id in (select event_id from tickets where user_id = ?)", id)
    end
end
