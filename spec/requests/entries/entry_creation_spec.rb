require "rails_helper"

RSpec.describe "Entry creation", type: :request do
  let(:question_count) { 7 }
  let!(:pool) { create(:pool, :with_questions, question_count:) }
  let(:membership) { create(:membership, pool: pool) }

  describe "POST /entries" do
    before { sign_in membership.user }

    it "creates a new entry" do
      expect do
        post "/pools/#{pool.id}/entries", params: { entry: { title: "New Entry", content: "Lorem ipsum" } }
      end.to change(Entry, :count).by(1)
    end

    it "creates as many choices as there are questions in the pool" do
      expect do
        post "/pools/#{pool.id}/entries", params: { entry: { title: "New Entry", content: "Lorem ipsum" } }
      end.to change(Choice, :count).by(question_count)
    end
  end
end
