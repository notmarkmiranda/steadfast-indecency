# Preview all emails at http://localhost:3000/rails/mailers/invite
class InvitePreview < ActionMailer::Preview
  def invite_new_member_existing
    membership = FactoryBot.create(:membership)
    InviteMailer.with(membership: membership, new_user: false).invite_new_member
  end

  def invite_new_member_new
    membership = FactoryBot.create(:membership)
    InviteMailer.with(membership: membership, new_user: true).invite_new_member
  end
end
