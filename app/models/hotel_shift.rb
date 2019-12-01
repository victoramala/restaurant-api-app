class HotelShift < ApplicationRecord
  belongs_to :hotel
  validates :name,:presence => true
  validate :shift_start_and_end_time_check
  def shift_start_and_end_time_check
    unless  start_time.blank? and end_time.blank?
      if start_time >= end_time
        errors.add(:end_time, "end time can’t be less then the start time")
      end
    end
  end
end
