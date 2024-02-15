class InviteMailer < ApplicationMailer
  include Rails.application.routes.url_helpers
  attr_reader :membership, :new_user, :pool, :user

  def invite_new_member
    @membership = params[:membership]
    @pool = membership.pool
    @new_user = params[:new_user]
    @user = membership.user
    @invite_pool_path = invite_url

    mail(to: @user.email, subject: "You've been invited to join a pool!")
  end

  def invite_url
    if new_user
      edit_user_password_url(
        reset_password_token: reset_token,
        id: pool.id,
        token: membership.invitation_token
      )
    else
      invite_pool_url(id: pool.id, token: membership.invitation_token)
    end
  end

  def reset_token
    new_user ? user.send(:set_reset_password_token) : membership.invitation_token
  end
end
