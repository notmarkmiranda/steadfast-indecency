require "rails_helper"

RSpec.describe PoolCreationService do
  it "creates a pool" do
    user = create(:user)
    pool_params = attributes_for(:pool)

    pcs = PoolCreationService.new(pool_params, user.id)
    expect { pcs.save! }.to change(Pool, :count).by(1)
  end

  it "creates a super admin" do
    user = create(:user)
    pool_params = attributes_for(:pool)

    pcs = PoolCreationService.new(pool_params, user.id)

    expect { pcs.save! }.to change(Membership, :count).by(1)

    expect(Membership.last.role).to eq("super_admin")
    expect(Membership.last.active).to eq(true)
  end
end
