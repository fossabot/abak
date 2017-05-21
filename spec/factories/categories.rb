FactoryGirl.define do
  factory :category do
    name { Faker::Hacker.adjective }
  end
end
