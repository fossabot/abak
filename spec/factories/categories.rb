# -*- encoding : utf-8 -*-
FactoryGirl.define do
    factory :category do
        sequence(:id ) { |i| "#{i}" }
        sequence(:name) { |i| "homepage#{i}" }
    end
end
