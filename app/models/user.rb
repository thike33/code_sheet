class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_posts, through: :bookmarks, source: :post
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  validates :name, presence: true, length: { maximum: 100 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader

  def own?(object)
    id == object&.user_id
  end

  # ブックマーク用のメソッド
  # 投稿をユーザーのブックマークに追加
  def bookmark(post)
    bookmark_posts << post
  end

  # 投稿をユーザーのブックマークから削除
  def unbookmark(post)
    bookmark_posts.destroy(post)
  end

  # 投稿がユーザーのブックマークに含まれているか確認
  def bookmark?(post)
    bookmark_posts.include?(post)
  end

  # いいね用のメソッド
  # 指定された投稿に対して、ユーザーがいいねをしているか確認
  def like?(post)
    post.likes.pluck(:user_id).include?(self.id)
  end

  # 指定された投稿にいいねを追加
  def like(post)
    like_posts << post
  end

  # 指定された投稿に対するいいねを削除
  def unlike(post)
    like_posts.destroy(post)
  end
end
