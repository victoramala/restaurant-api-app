class UserMailer < ApplicationMailer
  default from: "victoramala021@gmail.com"

  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email')
  end

  def guest_notify(reservation, flag)
    @reservation =  reservation
    @guest = @reservation.guest
    @booking_status = flag
    if @booking_status == "updated"
      mail(to: @guest.email, subject: 'Reservation updated')
    else
      mail(to: @guest.email, subject: 'Reservation booked')
    end
  end

  def restaurant_notify(reservation, flag)
    @reservation = reservation
    @restaurant = @reservation.hotel_table.hotel
    @booking_status = flag
    if @booking_status == "updated"
      mail(to: @restaurant.email, subject: 'Reservation updated')
    else
      mail(to: @restaurant.email, subject: 'Reservation booked')
    end
  end
end
