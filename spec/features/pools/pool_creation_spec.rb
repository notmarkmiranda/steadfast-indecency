require "rails_helper"

RSpec.describe "Pool creation", type: :feature do
  let(:user) { create(:user) }

  before { sign_in user }
  let(:cutoff) { DateTime.tomorrow.in_time_zone("America/Denver").at_midday }
  let(:event) { (DateTime.tomorrow + 7.days).in_time_zone("America/Denver").at_midday + 1.hour }

  it "creates a pool and shows cutoff and event times as MT" do
    visit new_pool_path

    fill_in "Name", with: "Pool creation spec"
    fill_in "Description", with: "This is a pool created by a feature spec to check for creation and time zones"
    fill_in "Cutoff date", with: cutoff
    fill_in "Event date", with: event

    click_button "Create Pool"

    expect(current_path).to eq(pool_path(Pool.last.id))
    expect(page).to have_content("All times are in Mountain Time")
    expect(page).to have_content(cutoff.in_time_zone("America/Denver").strftime("%l:%M %p"))
    expect(page).to have_content(event.in_time_zone("America/Denver").strftime("%l:%M %p"))
  end
end