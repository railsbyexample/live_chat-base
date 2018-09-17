class AccountsController < ApplicationController
  before_action :block_private_tenant!
  def new
    @user = User.new
    @account = Account.new
  end

  def create
    @user = User.new(user_params)
    @account = Account.new(account_params)

    account_result = create_account
    (render(:new, location: new_account_path) && return) unless account_result.success?

    create_tenant

    user_result = create_user_in_new_tenant
    unless user_result.success?
      clean_up_account
      render :new, location: new_account_path
      return
    end

    redirect_to new_account_path,
                notice: 'Your account has been successfully created, please confirm your email to continue'
  end

  private

  def account_params
    params.require(:account).permit(:subdomain)
  end

  def user_params
    params.require(:user)
          .permit(:email, :password, :password_confirmation)
  end

  def create_account
    @account = Account.create(account_params)
    OpenStruct.new(success?: @account.persisted?)
  end

  def create_tenant
    Apartment::Tenant.create(account_params[:subdomain])
  end

  def create_user_in_new_tenant
    Apartment::Tenant.switch(account_params[:subdomain]) do
      @user = User.create(user_params) do |user|
        user.admin_level = :owner
        user.save
      end
      OpenStruct.new(success?: @user.persisted?)
    end
  end

  def clean_up_account
    destroy_account
    destroy_tenant
  end

  def destroy_account
    @account.destroy
  end

  def destroy_tenant
    Apartment::Tenant.drop @account.subdomain
  end
end
