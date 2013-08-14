# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

al = User.create(email: "albie@example.com", full_name: "Albert Agram", password: "12345", admin: true)
john = User.create(email: "john@example.com", full_name: "john Smith", password: "1234abcd")

drama = Genre.create(name: "Drama")
action = Genre.create(name: "Action")
documentary = Genre.create(name: "Documentary")
romance = Genre.create(name: "Romance")
comedy = Genre.create(name: "Comedy")