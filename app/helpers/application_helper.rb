module ApplicationHelper
  def time_ago(time)
    time_ago_in_words(time, scope: "datetime.distance_in_words.short")
  end

  def contact_email
    Settings.instance.contact_email
  end
end
