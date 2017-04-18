# -*- encoding : utf-8 -*-
FactoryGirl.define do

    factory :category do
        
        # unique id name of category
        sequence(:id ) { |i| "#{i}" }
        sequence(:name) { |i| "homepage#{i}" }

    end

end
