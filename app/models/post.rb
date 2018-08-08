class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :comments, dependent: :destroy

  mount_uploader :cover, BlogImageUploader

  def self.search(search)
    where("title ILIKE ? OR body ILIKE ?", "%#{search}%", "%#{search}%")
  end
end
