module ApplicationHelper
  def avatar_url(user)
    @image = user.image
    if user.uid
      "https://graph.facebook.com/#{user.uid}/picture?type=large"
    else
      if user.image.present?
        @image.url
      else
        "default.png"
      end
    end
  end 
end