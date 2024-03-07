require "rails_helper"

RSpec.describe "Invited user is redirected when accessing pending membership", type: :feature do
  let(:membership) { create(:membership, active: false) }
  let(:pool) { membership.pool }
  let(:user) { membership.user }

  before { sign_in user }
  it "redirects the user to invite pool page" do
    visit pool_path(pool)

    expect(current_path).to match(%r{/pools/\d+/invite/\w+})
  end
end