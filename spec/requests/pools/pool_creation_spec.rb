require "rails_helper"

RSpec.describe "Pool creation", type: :request do
  before { sign_in create(:user) }

  let(:pool_params) do
    {
      name: "pool name",
      description: "pool description",
      cutoff_date: Date.tomorrow.in_time_zone("America/Denver").at_midday,
      event_date: Date.tomorrow.in_time_zone("America/Denver").at_midday + 1.hour
    }
  end

  it "saves event and cutoff datetime as UTC in the database" do
    post "/pools", params: {pool: pool_params}

    pool = Pool.last
    # this validates that it is being saved in UTC in the database
    expect(pool.cutoff_date.hour).to eq(19)
    expect(pool.event_date.hour).to eq(20)
  end
end
