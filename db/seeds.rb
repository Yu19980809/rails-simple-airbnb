# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'Deleting previous flats...'
Flat.destroy_all
puts 'Finished deleting'

puts 'Adding new flats...'

5.times do
  flat = Flat.new
  flat.name = Faker::Restaurant.name
  flat.address = Faker::Address.street_address
  flat.description = Faker::Restaurant.description
  flat.price_per_night = Faker::Number.decimal(l_digits: 2)
  flat.number_of_guests = Faker::Number.non_zero_digit
  flat.save

  puts "Added #{flat.id} - #{flat.name}"
end

puts "Finished adding, #{Flat.count} flats have been added."
