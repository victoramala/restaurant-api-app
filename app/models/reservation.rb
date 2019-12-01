class Reservation < ApplicationRecord
  belongs_to :guest
  belongs_to :hotel_table
  validate :reservation_guest_count_check
  # validate :reservation_time_check
  def reservation_guest_count_check
    if guest_count and guest_count > 0
      unless guest_count.between?(self.hotel_table.min_guest_count,self.hotel_table.max_guest_count )
        errors.add(:guest_count, "Guest count must between #{self.hotel_table.min_guest_count if self.hotel_table.min_guest_count } - #{self.hotel_table.max_guest_count if self.hotel_table.max_guest_count}")
      end
    else
      errors.add(:guest_count, "Guest count invalid")
    end
  end

  # def reservation_time_check
  #   c= self.hotel_table.hotel.hotel_shifts.where("start_time <= ? and end_time > ?", reservation_time, reservation_time)
  #   if c.count > 0
  #     errors.add(:reserve_time, "time slot not available")
  #   end
  # end
end
