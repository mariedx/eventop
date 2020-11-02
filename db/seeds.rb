#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

#create random users
15.times do 
  User.create(email: Faker::Name.first_name+Faker::Name.last_name+"@yopmail.com",
    encrypted_password: Faker::String.random(length: 6..12),
    description: Faker::TvShows::Community.quotes,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name)
end