class Post < ApplicationRecord
  has_many :codes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :likes, dependent: :destroy
  accepts_nested_attributes_for :codes, allow_destroy: true
  belongs_to :user

  validates :title, presence: true, length: { maximum: 100 }

  mount_uploader :image, ImageUploader
end
