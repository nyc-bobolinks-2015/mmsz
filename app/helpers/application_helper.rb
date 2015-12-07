module ApplicationHelper
  def show_age model
    seconds_old = (Time.now - model.created_at).to_i
    if seconds_old < 60
      "#{seconds_old} seconds"
    elsif seconds_old < 3600
      "#{seconds_old / 60} minutes"
    else
      "#{seconds_old / 3600} hours"
    end
  end
end
