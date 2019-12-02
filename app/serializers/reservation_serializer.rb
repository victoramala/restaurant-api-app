class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :guest_count, :reservation_time, :guest
  belongs_to :guest
  belongs_to :hotel_table
end
