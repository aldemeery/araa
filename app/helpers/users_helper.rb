module UsersHelper
  def following_action_path(user)
    if user != logged_user
      return logged_user.follows?(user) ? unfollow_path(user) : follow_path(user)
    end
    ""
  end

  def action_icon(user)
    if user != logged_user
      return logged_user.follows?(user) ? "fa-close" : "fa-plus user-profile-add-icon"
    end
    ""
  end

  def followed(user)
    logged_user.follows?(user) ? "followed" : ""
  end
end

