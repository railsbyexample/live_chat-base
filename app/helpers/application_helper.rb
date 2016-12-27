module ApplicationHelper
  def gravatar_for(user, opts = {})
    image_tag user ? "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{opts.delete(:size) { 40 }}" : '', opts
  end
end
