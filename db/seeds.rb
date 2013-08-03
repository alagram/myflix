# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

al = User.create(email: "albie@example.com", full_name: "Albert Agram", password: "12345")
john = User.create(email: "john@example.com", full_name: "john Smith", password: "1234abcd")

drama = Genre.create(name: "Drama")
action = Genre.create(name: "Action")
documentary = Genre.create(name: "Documentary")
romance = Genre.create(name: "Romance")
comedy = Genre.create(name: "Comedy")

hangover3 = Video.create(title: "Hangover 3", description: "funny movie.", small_cover_url: "/tmp/hangover_3.jpg", large_cover_url: "/tmp/monk_large.jpg")
america = Video.create(title: "Coming To America", description: "Eddie Murphy.", small_cover_url: "/tmp/coming_to_america.jpg", large_cover_url: "/tmp/monk_large.jpg")
spring = Video.create(title: "Spring Breakers", description: "College kids gone wild!.", small_cover_url: "/tmp/spring_breakers.jpg", large_cover_url: "/tmp/monk_large.jpg")
family_guy = Video.create(title: "Family Guy", description: "very funny movie.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/monk_large.jpg")
ted = Video.create(title: "Ted", description: "About a man and his teddy bear.", small_cover_url: "/tmp/ted.jpg", large_cover_url: "/tmp/monk_large.jpg")
south_park = Video.create(title: "South Park", description: "You don't wanna miss this!", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/monk_large.jpg")
futurama = Video.create(title: "Futurama", description: "Nice.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/monk_large.jpg")
dictator =  Video.create(title: "The Dictator", description: "This guy is mean...", small_cover_url: "/tmp/the_dictator.jpg", large_cover_url: "/tmp/monk_large.jpg")

hangover3.genres << comedy
america.genres << comedy
sunset.genres << romance
ted.genres << documentary
spring.genres << action
futurama.genres << action

Review.create(content: "Not bad.", user: john, video: hangover3, rating: "3")
Review.create(content: "I love this!.", user: al, video: america, rating: "5")
Review.create(content: "This one will grow on me.", user: john, video: futurama, rating: "3.5")
Review.create(content: "LMFAO kinda funny!.", user: al, video: dictator, rating: "3")

