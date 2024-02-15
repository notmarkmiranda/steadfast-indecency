class PasswordsController < Devise::PasswordsController
  def edit
    if params["id"].present? && params["token"].present?
      store_location_for(:user, invite_pool_path(id: params["id"], token: params["token"]))
    end
    super
  end
end