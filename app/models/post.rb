class Post < ApplicationRecord
  has_many :codes, dependent: :destroy
  accepts_nested_attributes_for :codes
  belongs_to :user

  validates :title, presence: true, length: { maximum: 100 }

  mount_uploader :image, ImageUploader
end
