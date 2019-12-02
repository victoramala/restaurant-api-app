class Api::V1::GuestsController < ApplicationController
  before_action :load_guest, only: [:show, :update, :destroy]

  def index
    @guests = Guest.all
    guests_serializer = parse_json @guests
    json_response "listing guests successfully", true, {guests: guests_serializer}, :ok
  end

  def show
    guest_serializer = parse_json @guest
    json_response "Show guest successfully", true, {guest: guest_serializer}, :ok
  end

  def create
    guest = Guest.new(guest_params)
    if guest.save
      guest_serializer = parse_json guest
      json_response "guest created successfully", true, {guest: guest_serializer}, :ok
    else
      json_response guest.errors, false, {}, :unprocessable_entity
    end
  end

  def update
    if @guest.update guest_params
      guest_serializer = parse_json @guest
      json_response "guest updated successfully", true, {guest: guest_serializer}, :ok
    else
      json_response @guest.errors, false, {}, :unprocessable_entity
    end
  end

  def destroy
    if @guest.destroy
      json_response "guest delete successfully", true, {}, :ok
    else
      json_response "guest delete failed", false, {}, :unprocessable_entity
    end
  end

  private

    def load_guest
      @guest = Guest.find_by id: params[:id]
      unless @guest.present?
        json_response "can not find a guest", false, {}, :not_found
      end
    end

    def guest_params
    	params.require(:guest).permit!
      # (:name, :min_guest_count, :max_guest_count)
    end
end
