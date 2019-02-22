# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts 'Creating 20 fake users...'
4.times do
  user = User.new(
    last_name: Faker::Name.last_name,
    first_name: Faker::Name.first_name,
    email: Faker::Internet.free_email,
    password: "123456",
    remote_photo_url: "http://lorempixel.com/400/200/people/",
    bio: Faker::ChuckNorris.fact,
    phone_number: Faker::PhoneNumber.phone_number
    )
  user.save!
end

require 'faker'

puts 'Creating 20 fake flats...'
20.times do
  flat = Flat.new(
    address: "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.zip_code}",
    description: Faker::Lorem.sentence,
    price: (10..100).to_a.sample,
    capacity: Faker::Number.between(1, 10),
    remote_photo_url: "http://lorempixel.com/400/200/city/",
    user: User.all.sample
  )
  flat.save!
end
puts 'Finished!'
