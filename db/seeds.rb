require "faker"

20.times do
  Post.create!(
    content: Faker::Lorem.sentence,
    )
end