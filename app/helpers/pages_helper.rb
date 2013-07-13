module PagesHelper

  # Returns the Gravator (http://gravatar.com/) for the given user.
  def chapter_page_url(chapter_num, page_num)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.first_name + " " + user.last_name, class: "gravatar")
  end
end
