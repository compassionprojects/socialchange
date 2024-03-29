# Stories helper
#
module StoriesHelper
  def can_edit?(story)
    user_signed_in? && policy(story).update?
  end

  def can_destroy?(story)
    user_signed_in? && policy(story).destroy?
  end

  def can_add_story_update?(story)
    user_signed_in? && policy(StoryUpdate.new(story:, user: current_user)).new?
  end

  def display_rich_text(text)
    sanitize(text, tags: %w[strong em b i p sub sup cite br ul ol li blockquote a])
  end
end
