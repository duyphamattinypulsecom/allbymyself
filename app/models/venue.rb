class Venue < ActiveRecord::Base
  belongs_to :region
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  
  validates_uniqueness_of :name
end
