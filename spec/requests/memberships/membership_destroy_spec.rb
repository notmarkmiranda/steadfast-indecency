require "rails_helper"

RSpec.describe "Membership destroy", type: :request do
  let(:question_count) { 7 }
  let!(:pool) { create(:pool, :with_questions, question_count:) }
  let(:membership) { create(:membership, pool: pool) }

  before { sign_in(membership.user) }

  describe "when someone rejects a membership request" do
    it "destroys a membership" do
      expect { delete membership_path(membership) }.to change(Membership, :count).by(-1)
    end

    describe "when the user has no other memberships" do
      it "schedules a job to destroy the user in 3 days" do
        expect { delete membership_path(membership) }.to have_enqueued_job(DestroyUserJob)
      end
    end
  end

  describe "when someone is removed from a pool" do
    before do
      create(:membership, role: :super_admin, pool: pool)
      sign_in(pool.superadmin)
    end

    it "destroys a membership" do
      expect { delete pool_membership_path(pool, membership) }.to change(Membership, :count).by(-1)
    end

    it "destroys an associated entry and choices" do
      EntryCreationService.new({pool_id: pool.id, user_id: membership.user.id}, pool.questions_count).save!

      expect { delete pool_membership_path(pool, membership) }.to change(Entry, :count).by(-1).and change(Choice, :count).by(-question_count)
    end
  end
end
