require "rails_helper"

RSpec.describe InviteMailer, type: :mailer do
  describe ".invite_new_member" do
    let(:membership) { create(:membership) }
    let(:mail) { InviteMailer.with(membership: membership, new_user: new_user).invite_new_member }

    describe "when the user is not new" do
      let(:new_user) { false }

      it "renders the headers" do
        expect(mail.subject).to eq("You've been invited to join a pool!")
        expect(mail.to).to eq([membership.user.email])
        expect(mail.from).to eq(["hello@markmiranda.org"])
      end

      it "renders the body" do
        allow(membership).to receive(:invitation_token).and_return("1234").twice

        expect(mail.body.encoded).to include("You have been invited to join a prop bet pool named #{membership.pool.name}. Please click the link below to review this invitation.")
        expect(mail.body.encoded).to match(/\/pools\/\d+\/invite\/1234/)
      end
    end

    describe "when the user is new" do
      let(:new_user) { true }

      it "renders the headers" do
        expect(mail.subject).to eq("You've been invited to join a pool!")
        expect(mail.to).to eq([membership.user.email])
        expect(mail.from).to eq(["hello@markmiranda.org"])
      end

      it "renders the body" do
        expect(mail.body.encoded).to include("You have been invited to join a prop bet pool named #{membership.pool.name}. Please click the link below to review this invitation.")
        expect(mail.body.encoded).to match(/\/users\/password\/edit/)
      end
    end
  end
end
