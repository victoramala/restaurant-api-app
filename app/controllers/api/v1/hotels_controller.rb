class Api::V1::HotelsController < ApplicationController
  before_action :load_hotel,  only: [:show, :update, :destroy]
  def index
    @hotels= hotel.all
    json_response "Listing hotels uccessfully", true, {hotels: @hotels}, :ok
  end

  def show
    json_response "Showing hotel successfully", true, {hotel: @hotel}, :ok
  end

  def create
    hotel = Hotel.new(hotel_params)
    if hotel.save
      json_response "hotel created successfully", true, {hotel: hotel}, :ok
    else
      json_response hotel.errors, false, {}, :unprocessable_entity
    end
  end

  def update
    if @hotel.update hotel_params
      json_response "hotel updated successfully", true, {hotel: @hotel}, :ok
    else
      json_response hotel.errors, false, {}, :unprocessable_entity
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
