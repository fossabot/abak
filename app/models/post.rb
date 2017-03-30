class Post < ActiveRecord::Base
	belongs_to :category
	validates :title, :preview, :body, presence: true
end
