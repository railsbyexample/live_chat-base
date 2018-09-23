class PagesController < ApplicationController
  def index
    user_signed_in? ? redirect_to(contacts_url) : redirect_to(new_user_registration_url)
  end
end
