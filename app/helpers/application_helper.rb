module ApplicationHelper

  def fetch_image(attachment)
    return "small/missing.jpg" if attachment.blank?
    return attachment.photo.url(:small)
  end
end
