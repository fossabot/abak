class Category < ActiveRecord::Base

	extend FriendlyId

	friendly_id :name, use: :slugged
	has_many :posts
	validates :name, presence: true
	validates_associated :posts
	validates_format_of :name, :with => /\A[a-zA-Z0-9]+\z/, :message => "Only letters and numbers allowed"
	has_ancestry
	
end
