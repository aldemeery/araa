class User < ApplicationRecord
  has_many :opinions, dependent: :destroy
  has_many :followings, foreign_key: :follower_id
  has_many :followers, class_name: :Following, foreign_key: :followed_id

  def follow(user)
    followings.create({ followed_id: user.id })
  end

  def unfollow(user)
    followings.where({ followed_id: user.id }).destroy_all
  end

  def post(content)
    opinions.create({ text: content })
  end
end
