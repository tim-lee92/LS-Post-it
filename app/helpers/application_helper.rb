module ApplicationHelper
  def format_url(string)
    string.starts_with?('http://') || string.starts_with?('https://') ? string : "https://#{string}"
  end

  def format_datetime(time)
    time.strftime("%m-%d-%y %l:%M%P %Z")
  end
end
