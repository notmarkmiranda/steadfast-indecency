require "rails_helper"

RSpec.feature "Admin can add question" do
  let(:pool) { create(:pool, cutoff_date: Date.tomorrow, event_date: 2.days.from_now) }
  let(:membership) { create(:membership, role: 2, pool: pool) }
  let(:admin) { membership.user }

  before do
    sign_in admin
  end

  it "admin can add question with 2 options" do
    question = "Who will win Superb Owl 2024?"
    option_1 = "KC Chiefs"
    option_2 = "SF 49ers"

    visit pool_path(pool)

    fill_in "Question", with: question
    fill_in "Option 1", with: option_1
    fill_in "Option 2", with: option_2

    click_button "Create Question"

    expect(page).to have_content("Pool Details")
    expect(page).to have_content("Question was successfully created.")
    expect(page).to have_content(question)
    expect(page).to have_content(option_1)
    expect(page).to have_content(option_2)
  end
end
