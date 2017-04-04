class Post < ActiveRecord::Base

	extend FriendlyId

	friendly_id :title, use: :slugged
	belongs_to :category
	validates :title, :preview, :body, presence: true

end