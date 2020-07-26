class User < ApplicationRecord
  before_destroy :destroy_relations

  has_many :opinions, dependent: :destroy
  has_many :followings, foreign_key: :follower_id
  has_many :followers, class_name: :Following, foreign_key: :followed_id

  mount_uploader :photo, PhotoUploader
  mount_uploader :cover_image, CoverImageUploader

  serialize :pohto, JSON
  serialize :cover_image, JSON

  validates :username, uniqueness: true, presence: true, length: { maximum: 100 }
  validates :full_name, presence: true, length: { maximum: 100 }
  validates :photo, presence: true
  validates :cover_image, presence: true
  # validate :photo_size
  # validate :cover_size

  def follow(user)
    followings.create({ followed_id: user.id }) unless follows?(user)
  end

  def unfollow(user)
    followings.where({ followed_id: user.id }).destroy_all
  end

  def post(content)
    opinions.create({ text: content })
  end

  def follows?(user)
    followings.where(followed_id: user.id).exists?
  end

  def followers_ids
    followers.select('follower_id').pluck('follower_id').to_a
  end

  def followings_ids
    followings.select('followed_id').pluck('followed_id').to_a
  end

  private

  def destroy_relations
    followers.destroy_all
    followings.destroy_all
    opinions.destroy_all
  end
end
