FactoryBot.define do
  factory :user do
    name { "test" }
    password { "password" }
    profile { nil }
    blog_url { nil }

    trait :without_name do
      name { "" }
    end

    trait :name_size_20 do
      name { Faker::Base.regexify("[a-zA-Z]{20}") }
    end

    trait :name_size_21 do
      name { Faker::Base.regexify("[a-zA-Z]{21}") }
    end

    trait :name_japanese do
      name { Faker::Name.first_name }
    end

    trait :name_include_num do
      name { Faker::Lorem.characters(min_alpha: 1, min_numeric: 1) }
    end

    trait :name_include_space do
      name { Faker::Name.name }
    end

    trait :name_include_half_space do
      name { Faker::Name.name }
    end

    trait :name_include_full_space do
      name { Faker::Name.name }
    end


  end
end
