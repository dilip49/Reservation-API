class Api::V1::ReservationsController < ApplicationController
  attr_reader :reservation

  def create
    # when payload is invalid
    render json: { message: t(:invalid) } and return unless payload_valid?

    new_reservation = build_or_update_reservation

    # update reservation if already exists
    render json: { reservation: reservation, message: I18n.t('reservation.updated') } and return if reservation.present?

    if new_reservation.save
      render json: { reservation: new_reservation, message: I18n.t('reservation.successfully') }, status: :ok
    else
      render json: { message: new_reservation.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  private

  def payload_valid?
    params[:guest].present? || params[:reservation][:guest_details].present?
  end

  def fetch_reservation
    reservation_hash = BuildReservation.call(params)

    if find_reservation(reservation_hash[:reservation][:code]).present?
      return reservation.update(reservation_hash[:reservation])
    end

    guest = Guest.create(reservation_hash[:guest])
    Reservation.new(reservation_hash[:reservation].merge(guest_id: guest.id))
  end

  def find_reservation(code)
    @reservation = Reservation.find_by_code(code)
  end
end
