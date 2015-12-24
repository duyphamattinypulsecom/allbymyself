class AddNoOfBookedToTicketType < ActiveRecord::Migration
  def change
    add_column :ticket_types, :no_of_booked, :integer, :default => 0
  end
end
