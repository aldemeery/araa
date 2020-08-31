module UsersHelper
  def following_action_path(user)
    if user != logged_user
      return logged_user.follows?(user) ? unfollow_path(user) : follow_path(user)
    end

    ''
  end

  def action_icon(user)
    if user != logged_user
      return logged_user.follows?(user) ? 'fa-close' : 'fa-plus user-profile-add-icon'
    end

    ''
  end

  def followed(user)
    logged_user.follows?(user) ? 'followed' : ''
  end

  def action(user)
    return if user == logged_user

    link_to(following_action_path(user)) do
      ('<i class="fa ' + action_icon(user) + '"></i>').html_safe
    end
  end

  def follow_action(user)
    return if user == logged_user

    ('<a href="' + following_action_path(user) +
      '" class="follower-follow no-decor ' + followed(user) + '">' \
      '<i class="fa ' + action_icon(user) + '"></i>' \
    '</a>').html_safe
  end
end
