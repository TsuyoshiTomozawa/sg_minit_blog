require "faker"
Faker::Config.locale = :en

User.create!(name: "admin",
             password: "password",
             password_confirmation: "password")

10.times do |n|
  name = Faker::Name.first_name
  password = "password"
  User.create!(name: name,
               password: password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
30.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.posts.create!(content: content) }
end