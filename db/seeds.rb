# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

gen1 = Genre.create(name: "Comedies")
hangover_3 = Video.create(title: "Hangover 3", description: "funny movie.", small_cover_url: "/tmp/hangover_3.jpg", large_cover_url: "/tmp/monk_large.jpg")