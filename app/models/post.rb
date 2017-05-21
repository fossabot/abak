class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :category, optional: true
  validates :title, :preview, :body, presence: true
end
