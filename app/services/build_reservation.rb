class BuildReservation < ApplicationService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    if params[:guest].present?
      AirBnb.call(params)
    else
      Booking.call(params[:reservation])
    end
  end
end
