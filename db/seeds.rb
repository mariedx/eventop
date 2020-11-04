require 'faker'
require 'time'

# create random users
3.times do
  User.create!(email: Faker::Name.first_name+Faker::Name.last_name+"@yopmail.com",
  password: ["yellow1!!", "@coucou23", "4marseille?", "password-87", "!supersuper"].sample,
  description: Faker::TvShows::Community.quotes,
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name)
end
puts "*" * 20
puts "USERS"
puts tp User.all

#create random events
5.times do

  Event.create!(
  start_date: Faker::Date.between(from: Date.today, to: 1.year.from_now),
  duration: [15, 30, 45, 60, 90].sample,
  title: ["Pikachu", "Bulbizar", "Salameche", "Carapuce", "Roucoul", "Ratata", "Chenipan"].sample,
  description: "Evenement a destination des "+Faker::Job.title+" et qui ont vu récement "+Faker::Movie.title,
  price: Faker::Number.between(from: 1, to: 1000),
  location: ["rue de Mendoza", "avenue Bariloche", "rue de El Calafate", "impasse Buenos Aires", "place Salta", "boulevard Cordoba", "stade Rosario", "salle El Chalten"].sample,
  admin: User.all.sample)
end
puts "*" * 20
puts "EVENTS"
puts tp Event.all