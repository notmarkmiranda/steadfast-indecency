class InviteMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def invite_new_member
    membership = params[:membership]
    @user = membership.user
    @token = membership.invitation_token
    @invite_pool_path = invite_pool_url(id: membership.pool.id, token: @token)
    mail(to: @user.email, subject: "You've been invited to join a pool!")
  end
end
