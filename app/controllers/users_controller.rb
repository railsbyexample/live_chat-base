class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @confirmed_users = current_user.confirmed_users
  end
end
