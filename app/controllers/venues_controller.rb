class VenuesController < ApplicationController
  before_action :require_login, only: [:new, :create, :destroy]

  def new
    current_user.reload
  end

  def create
    @venue = Venue.new(venue_params)
    @venue.creator = current_user

    if @venue.save
        redirect_to new_venue_path
    else
        render 'new'
    end
  end

  def destroy
    Venue.delete(params[:id])
    redirect_to new_venue_path
  end

  private 
  def venue_params
    params.require(:venue).permit(:name, :full_address)
  end
end
