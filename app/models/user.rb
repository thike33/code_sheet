class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader

  def own?(object)
    id == object&.user_id
  end
end
