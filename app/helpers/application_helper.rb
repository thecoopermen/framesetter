module ApplicationHelper

  def avatar_url
    default = image_url('headshot.png')
    if logged_in?
      "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(current_user.email.downcase)}?d=#{URI::encode(default, /\W/)}"
    else
      default
    end
  end
end
