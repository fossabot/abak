class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :posts
  validates :name, presence: true
  validates_associated :posts
  validates_format_of :name, with: /\A[a-zA-Z0-9а-яёА-ЯЁ\s\-]+\z/, message: 'Only letters and numbers allowed'
  has_ancestry
  before_save :update_slug

  def update_slug
    name_as_slug = name.parameterize
    if parent.present?
      self.slug = [parent.slug, (slug.blank? ? name_as_slug : slug.split('/').last)].join('/')
    else
      self.name = name if slug.blank?
    end
  end
end
