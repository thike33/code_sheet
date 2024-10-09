class Post < ApplicationRecord
  has_many :codes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  accepts_nested_attributes_for :codes, allow_destroy: true
  belongs_to :user

  enum status: { public: 0, private: 1 }, _prefix: true

  validates :title, presence: true, length: { maximum: 100 }

  mount_uploader :image, ImageUploader

  def update_likes_count
    self.update(likes_count: self.likes.size)
  end

  # titleとdescriptionに対して検索を許可する
  def self.ransackable_attributes(auth_object = nil)
    %w[title description]
  end

  # 関連先のモデルを検索する必要がなければ空の配列を返す
  def self.ransackable_associations(auth_object = nil)
    []
  end
end
