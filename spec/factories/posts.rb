FactoryGirl.define do
  factory :post do
    title { Faker::Internet.slug }
    preview { Faker::Hacker.say_something_smart }
    body { Faker::Hacker.say_something_smart }
    category_id { Faker::Internet.slug }
  end
end
