FactoryBot.define do
  factory :post do
    content { "A test content." }

    trait :without_content do
      content { nil }
    end

    trait :content_size_140 do
      content { Faker::Lorem.characters(number: 140) }
    end

    trait :content_size_141 do
      content { Faker::Lorem.characters(number: 141) }
    end

    trait :post_day_ago do
      created_at { 1.day.ago }
      updated_at { 1.day.ago }
    end
  end
end
