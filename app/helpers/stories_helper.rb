# Stories helper
#
module StoriesHelper
  def can_edit?(story)
    user_signed_in? && policy(story).update?
  end

  def can_destroy?(story)
    user_signed_in? && policy(story).destroy?
  end
end
