module ApplicationHelper
  def format_url(string)
    string.starts_with?('http://') || string.starts_with?('https://') ? string : "https://#{string}"
  end

  def format_datetime(time)
    if (logged_in? && !current_user.time_zone.blank?)
      time = time.in_time_zone(current_user.time_zone)
    end
    time.strftime("%m-%d-%y %l:%M%P %Z")
  end
end
