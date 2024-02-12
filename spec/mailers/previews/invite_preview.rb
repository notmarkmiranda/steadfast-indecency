# Preview all emails at http://localhost:3000/rails/mailers/invite
class InvitePreview < ActionMailer::Preview
  def invite_new_member
    membership = FactoryBot.create(:membership)
    InviteMailer.with(membership: membership).invite_new_member
  end
end
