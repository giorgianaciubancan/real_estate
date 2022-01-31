module ApplicationHelper

  def profile_picture account
    thumb = account.image.present? ? account.image.url : "placeholder.png"
    image_tag thumb, class: "profile-pic img-circle"
  end

  def flash_notifications
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error' if type == 'alert' || type == 'danger'
      text = "toastr['#{type}']('#{message}');"
      flash_messages << text.html_safe unless message.blank?
    end
    "<script>$(function(){#{ flash_messages.join("\n")}});</script>".html_safe if flash_messages.any?
  end

end
