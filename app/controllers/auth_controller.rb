class AuthController < ApplicationController
  before_action :block_public_tenant!
end
