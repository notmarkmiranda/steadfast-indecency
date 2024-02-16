require "rails_helper"

RSpec.describe "Membership destroy", type: :request do
  let(:pool) { create(:pool) }
  let(:membership) { create(:membership, pool: pool) }

  before { sign_in(membership.user) }

  it "destroys a membership" do
    create(:membership, user: membership.user)

    expect { delete membership_path(membership) }.to change(Membership, :count).by(-1)
  end

  describe "when the user has no other memberships" do
    it "schedules a job to destroy the user in 3 days" do
      expect { delete membership_path(membership) }.to have_enqueued_job(DestroyUserJob)
    end
  end
end