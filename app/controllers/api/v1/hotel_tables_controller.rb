class Api::V1::HotelTablesController < ApplicationController
  before_action :load_hotel, only: :index
  before_action :load_hotel_table, only: [:show, :update, :destroy]

  def index
    @hotel_tables = @hotel.hotel_tables
    json_response "listing hotel_tables successfully", true, {hotel_tables: @hotel_tables}, :ok
  end

  def show
    json_response "Show hotel_table successfully", true, {hotel_table: @hotel_table}, :ok
  end

  def create
    hotel_table = HotelTable.new(hotel_table_params)
    hotel_table.hotel_id = params[:hotel_id]
    if hotel_table.save
      json_response "hotel_table created successfully", true, {hotel_table: hotel_table}, :ok
    else
      json_response hotel_table.errors, false, {}, :unprocessable_entity
    end
  end

  def update
    if @hotel_table.update hotel_table_params
      json_response "hotel_table updated successfully", true, {hotel_table: @hotel_table}, :ok
    else
      json_response @hotel_table.errors, false, {}, :unprocessable_entity
    end
  end

  def destroy
    if @hotel_table.destroy
      json_response "hotel_table delete successfully", true, {}, :ok
    else
      json_response "hotel_table delete failed", false, {}, :unprocessable_entity
    end
  end

  private
    def load_hotel
      @restaurant = Hotel.find_by id: params[:hotel_id]
      unless @restaurant.present?
        json_response "can not find a hotel", false, {}, :not_found
      end
   end

    def load_hotel_table
      @hotel_table = HotelTable.find_by id: params[:id]
      unless @hotel_table.present?
        json_response "can not find a hotel_table", false, {}, :not_found
      end
    end

    def hotel_table_params
    	params.require(:hotel_table).permit!
      # (:name, :min_guest_count, :max_guest_count)
    end
end
