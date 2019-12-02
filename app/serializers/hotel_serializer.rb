class HotelSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone
  has_many :hotel_tables
end
