class AccountsController < ApplicationController
  def new; end

  def create
    account_result = create_account
    (render(:new) && return) unless account_result.success?

    create_tenant

    user_result = create_user_in_new_tenant
    (render(:new) && return) unless user_result.success?

    redirect_to new_account_path,
                notice: 'Your account has been created, please confirm your email to continue'
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
end
