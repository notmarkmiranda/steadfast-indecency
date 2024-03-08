require "rails_helper"

RSpec.describe MembershipDeletorService do
  let!(:membership) { create(:membership) }
  let(:service) { described_class.new(membership_id: membership.id) }

  describe "#call" do
    it "deletes the membership" do
      expect { service.call }.to change(Membership, :count).by(-1)
    end
  end
end
