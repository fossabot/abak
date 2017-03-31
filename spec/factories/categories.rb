FactoryGirl.define do

	factory :category do
		
		# unique name of category
		sequence(:name) { |i| "homepage#{i}" }

	end

end