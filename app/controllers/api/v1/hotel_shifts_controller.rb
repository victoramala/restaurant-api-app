class Api::V1::HotelShiftsController < ApplicationController
  before_action :load_hotel, only: :index
  before_action :load_hotel_shift, only: [:show, :update, :destroy]

  def index
    @hotel_shifts = @hotel.hotel_shifts
    json_response "listing hotel_shifts successfully", true, {hotel_shifts: @hotel_shifts}, :ok
  end

  def show
    json_response "Show hotel_shift successfully", true, {hotel_shift: @hotel_shift}, :ok
  end

  def create
    hotel_shift = HotelShift.new(hotel_shift_params)
    hotel_shift.hotel_id = params[:hotel_id]
    if hotel_shift.save
      json_response "hotel_shift created successfully", true, {hotel_shift: hotel_shift}, :ok
    else
      json_response hotel_shift.errors, false, {}, :unprocessable_entity
    end
  end

  def update
    if @hotel_shift.update hotel_shift_params
      json_response "hotel_shift updated successfully", true, {hotel_shift: @hotel_shift}, :ok
    else
      json_response "hotel_shift update failed", false, {}, :unprocessable_entity
    end
  end

  def destroy
    if @hotel_shift.destroy
      json_response "hotel_shift delete successfully", true, {}, :ok
    else
      json_response "hotel_shift delete failed", false, {}, :unprocessable_entity
    end
  end

  private
    def load_hotel
      @hotel = Hotel.find_by id: params[:hotel_id]
      unless @hotel.present?
        json_response "can not find a hotel", false, {}, :not_found
      end
   end

    def load_hotel_shift
      @hotel_shift = RestaurantShift.find_by id: params[:id]
      unless @hotel_shift.present?
        json_response "can not find a hotel_shift", false, {}, :not_found
      end
    end

    def hotel_shift_params
      params.require(:hotel_shift).permit!
    end
end
