require "rails_helper"

RSpec.describe "Membership Creation", type: :request do
  let(:membership) { create(:membership, role: 1) }
  let(:pool) { membership.pool }

  before do
    sign_in membership.user
    allow(InviteMailer).to receive_message_chain(:with, :invite_new_member, :deliver_now)
  end

  it "creates a new membership" do
    expect do
      post "/pools/#{pool.id}/memberships", params: {membership: attributes_for(:membership).merge(email: "test@example.com")}
    end.to change(Membership, :count).by(1)
  end

  it "creates a new user" do
    expect do
      post "/pools/#{pool.id}/memberships", params: {membership: attributes_for(:membership).merge(email: "test@example.com")}
    end.to change(User, :count).by(1)
  end
end
