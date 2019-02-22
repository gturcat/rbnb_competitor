require 'open-uri'
require 'csv'
MARSEILLE_STREETS = []
csv_file = File.join(File.dirname(__FILE__), 'marseille_A_streets.csv')
CSV.foreach(csv_file) do |row| # Array
MARSEILLE_STREETS << row[0]
end
Booking.destroy_all
puts 'Detroy all Bookings'
Flat.destroy_all
puts 'Detroy all Flats'
# User.destroy_all
# puts 'Detroy all Users'
require 'faker'
# puts 'Creating 10 fake users...'
# i = 0
# 10.times do
# i+=1
# user = User.new(
# last_name: Faker::Name.last_name,
# first_name: Faker::Name.first_name,
# email: "air#{i}@bnb.com",
# password: "123456",
# remote_photo_url: "http://lorempixel.com/400/200/people/",
# bio: Faker::ChuckNorris.fact,
# phone_number: Faker::PhoneNumber.phone_number
# )
# user.save
# end
require 'faker'
titles = ["cozy flat", "Wonderfull panthouse", "Great Loft", "Splendid Home", "Joli maisonnette", "Chalet d'été"]
start_date = "01/02/2018".to_date
i = 0
puts start_date.class
puts start_date
puts start_date + 2
puts 'Creating 50 fake flats...'
50.times do
flat = Flat.new(
title: titles.sample,
address: "#{MARSEILLE_STREETS.sample}, Marseille",
description: Faker::Lorem.sentence,
price: (10..100).to_a.sample,
capacity: Faker::Number.between(1, 10),
remote_photo_url: "http://lorempixel.com/400/200/city/",
user: User.all.sample
)
flat.save
puts 'Creating 125 fake bookings for the flat ...'
Number.between(1, 125).times do
i += Faker::Number.between(1, 8)
booking = Booking.new(
start_date: start_date + i,
end_date: start_date + i + 3,
user: User.all.sample,
flat: flat
)
booking.save
end
end
puts 'Finished!'
