class HotelTable < ApplicationRecord
  belongs_to :hotel
  validates :name,:presence => true
  validate :min_guest_count_less_than_max_guest_count
  def min_guest_count_less_than_max_guest_count
    unless min_guest_count.blank? and max_guest_count.blank?
      if min_guest_count >= max_guest_count
        errors.add(:max_guest_count, "minimum guest count must be less than maximum guest count")
      end
    end
  end
end
