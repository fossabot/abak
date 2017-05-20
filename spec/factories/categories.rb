FactoryGirl.define do
  factory :category do
    sequence(:name) { |i| "homepage#{i}" }
  end
end
