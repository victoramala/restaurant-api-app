class HotelTableSerializer < ActiveModel::Serializer
  attributes :id, :name, :min_guest_count, :max_guest_count, :reservations
  has_many :reservations
end
