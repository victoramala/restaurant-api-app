Restaurant reservation - api app

Getting Started
  Builded API's for a Reservation management for restaurants using Ruby on rails as back end.

About
  1. Create an API endpoint that creates a reservation for the guest in a restaurant. The API should
  accept -
   * The table for reservation,
   * the restaurant shift in which you want the reservation, reservation time -- reservation time
  must lie within restaurant shift start time and end time,
   * guest who made the reservation, guest count for the reservation -- the guest count must be
  between maximum and minimum capacity of the table selected for reservation
   * When the reservation is created the restaurant should receive an email with guest details.
   * Create an API endpoint that updates the reservation - when the reservation details are changed,
  the guest should receive an email with - old and updated reservation time, old and updated guest
  count.
   * Create an API end point that returns a list of reservations for a restaurant. Reservation should
  have these fields - Reservation time, guest count, guest name, table name

Things to get the application up and running.

  * Ruby version - ruby '2.4.1'

  * bundle install

  * rails db:create

  * rails db:seed

  * rails s
