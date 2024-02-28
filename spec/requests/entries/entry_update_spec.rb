require "rails_helper"

RSpec.describe "Entry Update", type: :request do
  let(:pool) { create(:pool) }
  let(:admin) { create(:membership, pool: pool, role: 2).user }
  let(:entry) { create(:entry, pool: pool, user: admin, paid: false) }

  before { sign_in(admin) }
  
  describe "#paid" do
    it "marks an entry as paid" do
      post "/pools/#{pool.id}/entries/#{entry.id}/paid"
      
      entry.reload
      expect(entry.paid).to eq true
    end
  end

  describe "#unpaid" do
    before { entry.paid! }

    it "marks an entry as unpaid" do
      post "/pools/#{pool.id}/entries/#{entry.id}/unpaid"
      
      entry.reload
      expect(entry.paid).to eq false
    end
  end
end
