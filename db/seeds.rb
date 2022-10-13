# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Creating Workshops"

workshops = Workshop.create([
    {
      name: "Full Stack Ruby on Rails Development",
      description: "Dummy description for workshop.Dummy description for workshop.
                    Dummy description for workshop. Dummy description for workshop",
      start_date: Date.today + 4.days,
      end_date: Date.today + 9.days,
      start_time: "10:00 AM",
      end_time: "3:00 PM",
      total_seats: 100,
      remaining_seats: 0,
      registration_fee: 1500
    },
    {
      name: "ReactJs",
      description: "Dummy description for workshop.Dummy description for workshop.
                    Dummy description for workshop. Dummy description for workshop",
      start_date: Date.today + 22.days,
      end_date: Date.today + 29.days,
      start_time: "10:00 AM",
      end_time: "3:00 PM",
      total_seats: 100,
      remaining_seats: 0,
      registration_fee: 1200
    },
  ])

puts "Workshops created"