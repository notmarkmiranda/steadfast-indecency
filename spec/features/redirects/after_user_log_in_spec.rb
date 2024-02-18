require "rails_helper"

RSpec.describe "After user logs in", type: :feature do
  let(:membership) { create(:membership) }
  let(:user) { membership.user }
  let(:pool) { membership.pool }

  before { create(:membership, pool: pool, role: 2) }

  it "redirects to the last page the user visited" do
    visit pool_path(pool.id)

    fill_in "Email", with: user.email
    fill_in "Password", with: "password"

    click_button "Let's go!"
    expect(page).to have_content(pool.name)
  end

  it "redirects to the dashboard if the user has no previous page" do
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: "password"

    click_button "Let's go!"
    expect(page).to have_content("Welcome #{user.email}")
  end

  it "redirects to the invite page if the user was invited to a pool" do
    membership = create(:membership, user: user, pool: pool)

    visit edit_user_password_path(reset_password_token: user.send(:set_reset_password_token), id: pool.id, token: membership.invitation_token)
    fill_in "New password", with: "password"
    fill_in "Confirm new password", with: "password"

    click_button "Change my password"

    expect(page).to have_content("You have been invited to join the #{pool.name} pool.")
  end
end
