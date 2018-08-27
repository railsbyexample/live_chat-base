class PagesController < ApplicationController
  def index
    on_public_tenant? ? redirect_to(new_account_url) : redirect_to(users_url)
  end
end
