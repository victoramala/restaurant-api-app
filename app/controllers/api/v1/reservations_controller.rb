class Api::V1::ReservationsController < ApplicationController
  before_action :load_guest, only: [:create, :update]
  before_action :load_hotel_table, only: [:create, :update,:index]
  before_action :load_reservation, only: [:show, :update, :destroy]

  def index
    @reservations = @hotel_table.reservations
    reservations_serializer = parse_json @reservations
    json_response "listing reservations successfully", true, {reservations: reservations_serializer}, :ok
  end

  def show
    reservation_serializer = parse_json @reservation
    json_response "Show reservation successfully", true, {reservation: reservation_serializer}, :ok
  end

  def create
    reservation = Reservation.new(reservation_params)
    reservation.hotel_table_id = params[:reservation][:hotel_table_id]
    reservation.guest_id = params[:reservation][:guest_id]
    reservation_serializer = parse_json reservation
    if reservation.save
      flag = "created"
      # @guest = reservation.guest
      # @restaurant = reservation.restaurant_table.restaurant
      UserMailer.guest_notify(reservation, flag).deliver
      UserMailer.restaurant_notify(reservation, flag).deliver
      json_response "reservation created successfully", true, {reservation: reservation_serializer}, :ok
    else
      json_response reservation.errors, false, {}, :unprocessable_entity
    end
  end

  def update
    if @reservation.update reservation_params
      reservation_serializer = parse_json @reservation
      flag = "updated"
      UserMailer.guest_notify(@reservation, flag).deliver
      UserMailer.restaurant_notify(@reservation, flag).deliver
      json_response "reservation updated successfully", true, {reservation: reservation_serializer }, :ok
    else
      json_response @reservation.errors, false, {}, :unprocessable_entity
    end
  end

  def destroy
    if @reservation.destroy
      json_response "reservation delete successfully", true, {}, :ok
    else
      json_response "reservation delete failed", false, {}, :unprocessable_entity
    end
  end

  # def book_reservation
  #   reservation = Reservation.new(reservation_params)
  #   reservation.hotel_table_id = params[:reservation][:hotel_table_id]
  #   reservation.guest_id = params[:reservation][:guest_id]
  #   if reservation.save
  #     flag = "created"
  #     # @guest = reservation.guest
  #     # @restaurant = reservation.restaurant_table.restaurant
  #     UserMailer.guest_notify(reservation, flag).deliver
  #     UserMailer.restaurant_notify(reservation, flag).deliver
  #     json_response "reservation created successfully", true, {reservation: reservation}, :ok
  #   else
  #     json_response reservation.errors, false, {}, :unprocessable_entity
  #   end
  # end


  private
    def load_hotel_table
      @hotel_table = HotelTable.find_by id: params[:reservation][:hotel_table_id]
      unless @hotel_table.present?
        json_response "can not find a hotel_table", false, {}, :not_found
      end
   end

   def load_guest
      @guest = Guest.find_by id: params[:reservation][:guest_id]
      unless @guest.present?
        json_response "can not find a guest", false, {}, :not_found
      end
   end

    def load_reservation
      @reservation = Reservation.find_by id: params[:id]
      unless @reservation.present?
        json_response "can not find a reservation", false, {}, :not_found
      end
    end

    def reservation_params
      params.require(:reservation).permit!
      # (:name, :min_guest_count, :max_guest_count)
    end
end
