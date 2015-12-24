class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :ticket_type

  validates_numericality_of :quanlity, :greater_than => 0
end
