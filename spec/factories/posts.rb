FactoryGirl.define do
  factory :post do
    sequence(:id ) { |i| "#{i}" }
    title 'Any title'
    preview 'Any preview'
    body 'any body'
    category_id ''
  end
end
