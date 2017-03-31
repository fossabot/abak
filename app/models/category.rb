class Category < ActiveRecord::Base

	has_many :posts
	validates :name, presence: true
	validates_associated :posts
	has_ancestry
	
end
