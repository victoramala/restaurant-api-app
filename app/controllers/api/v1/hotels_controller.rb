class Api::V1::HotelsController < ApplicationController
  before_action :load_hotel,  only: [:show, :update, :destroy]
  def index
    @hotels= Hotel.includes(hotel_tables: [:reservations])
    hotels_serializer = parse_json @hotels
    json_response "Listing hotels uccessfully", true, {hotels: hotels_serializer}, :ok
  end

  def show
    hotel_serializer = parse_json @hotel
    json_response "Showing hotel successfully", true, {hotel: hotel_serializer}, :ok
  end

  def create
    hotel = Hotel.new(hotel_params)
    if hotel.save
      hotel_serializer = parse_json hotel
      json_response "hotel created successfully", true, {hotel: hotel_serializer}, :ok
    else
      json_response hotel.errors, false, {}, :unprocessable_entity
    end
  end

  def update
    if @hotel.update hotel_params
      hotel_serializer = parse_json @hotel
      json_response "hotel updated successfully", true, {hotel: hotel_serializer}, :ok
    else
      json_response @hotel.errors, false, {}, :unprocessable_entity
    end
  end

  def destroy
    if @hotel.destroy
      json_response "hotel delete successfully", true, {}, :ok
    else
      json_response "hotel delete failed", false, {}, :unprocessable_entity
    end
  end

  private
    def load_hotel
      @hotel = Hotel.find_by id: params[:id]
      unless @hotel.present?
        json_response "can not get hotel", false, {}, :not_found
      end
    end

    def hotel_params
    	params.require(:hotel).permit!
      # (:name, :min_guest_count, :max_guest_count)
    end

end
