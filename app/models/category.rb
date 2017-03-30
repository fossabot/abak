class Category < ActiveRecord::Base
	has_many :posts
	validates :name, presence: true
	has_ancestry
end
