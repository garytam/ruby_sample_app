module UsersHelper

  #returns the Gravator for the given user
  def gravator_for(user)
    # gravator_id = '4afe568b15f9ff387cb3fa9b5ddbb528'
    gravator_id = Digest::MD5::hexdigest(user.email)
    gravatar_url = "https://en.gravatar.com/avatar/#{gravator_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravator" )
  end
end
