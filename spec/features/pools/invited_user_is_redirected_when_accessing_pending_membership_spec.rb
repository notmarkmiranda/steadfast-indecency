require "rails_helper"

RSpec.describe "Invited user is redirected when accessing pending membership", type: :feature do
  let(:membership) { create(:membership, active: false) }
  let(:pool) { membership.pool }
  let(:user) { membership.user }

  before { sign_in user }
  it "redirects the user to invite pool page" do
    visit pool_path(pool)

    expect(page).to have_current_path(invite_pool_path(id: pool.id, token: "asdf"))
  end
end