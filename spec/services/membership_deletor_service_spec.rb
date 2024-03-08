require "rails_helper"

RSpec.describe MembershipDeletorService do
  let(:question_count) { 3 }
  let(:pool) { create(:pool, :with_questions, question_count:) }
  let!(:membership) { create(:membership, pool: pool) }
  let(:user) { membership.user }
  let(:service) { described_class.new(membership_id: membership.id) }

  describe "#call" do
    before { EntryCreationService.new({pool_id: pool.id, user_id: user.id}, question_count).save! }

    it "deletes the membership" do
      expect { service.call }.to change(Membership, :count).by(-1)
    end

    it "deletes associated entries & chocies" do
      expect { service.call }.to change(Entry, :count).by(-1).and change(Choice, :count).by(-question_count)
    end
  end
end
