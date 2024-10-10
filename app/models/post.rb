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

  scope :with_tag, ->(tag_name) { joins(:tags).where(tags: { name: tag_name }) }

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

  # トランザクションでタグを保存する
  def save_with_tags(tag_names:)
    ActiveRecord::Base.transaction do
      self.tags = tag_names.map { |name| Tag.find_or_initialize_by(name: name.strip) }
      save!
    end
    true
  rescue StandardError
    false
  end

  # タグの名前をカンマ区切りで返す
  def tag_names
    tags.map(&:name).join(',')
  end
end
