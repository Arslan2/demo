module ApplicationHelper

  def fetch_image(attachment)
    return "small/missing.jpg" if attachment.blank?
    return attachment.photo.url(:small)
  end

  def truncate_string(string, length)
    string.truncate(length.to_i,separator: " ")
  end
end
