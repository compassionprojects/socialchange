# Stories helper
#
module StoriesHelper
  def can_edit?
    user_signed_in? && policy(@story).update?
  end

  def can_destroy?
    user_signed_in? && policy(@story).destroy?
  end
end
