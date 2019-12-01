class Hotel < ApplicationRecord
  has_many :hotel_tables, dependent: :destroy
  has_many :hotel_shifts, dependent: :destroy
end
