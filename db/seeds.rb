# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)p "Seeding Restaurant"

20.times do |n|
 hotel = Hotel.create! name:Faker::Restaurant.name , email:Faker::Internet.email, phone:Faker::PhoneNumber.phone_number, description: Faker::Restaurant.description
 HotelTable.create! name:Faker::Compass.direction , min_guest_count: Faker::Number.between(from: 1, to: 5), max_guest_count:Faker::Number.between(from: 6, to: 20) , hotel_id: hotel.id
 HotelShift.create! name:Faker::Number.between(from: 1, to: 3), start_time:Faker::Time.backward(days: 5, period: :morning) , end_time:Faker::Time.backward(days: 5, period: :evening), hotel_id: hotel.id
end

10.times do |g|
  Guest.create! name:Faker::Name.unique.name , email:Faker::Internet.email
end
