# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
User.create!(name:  "User",
             email: "user@email.com")

99.times do |n|
  User.create!(name:  Faker::Name.name,
               email: "user-#{n+1}@email.org")
end

# Following friendships
users = User.all
user  = users.first
following = users[2..5]
followers = users[3..4]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }