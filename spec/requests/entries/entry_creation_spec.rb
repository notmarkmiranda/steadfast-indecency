require "rails_helper"

RSpec.describe "Entry creation", type: :request do
  let(:question_count) { 7 }
  let!(:pool) { create(:pool, :with_questions, question_count:) }
  let(:membership) { create(:membership, pool: pool) }

  describe "POST /entries" do
    before { sign_in membership.user }

    describe "before the cutoff has passed" do
      it "creates a new entry" do
        expect do
          post "/pools/#{pool.id}/entries"
        end.to change(Entry, :count).by(1)
      end

      it "creates as many choices as there are questions in the pool" do
        expect do
          post "/pools/#{pool.id}/entries"
        end.to change(Choice, :count).by(question_count)
      end
    end

    describe "after the cutoff has passed" do
      before { pool.update(cutoff_date: DateTime.yesterday) }

      it "does not create a new entry" do
        expect do
          post "/pools/#{pool.id}/entries"
        end.not_to change(Entry, :count)
      end
      
      it "does not create any choices" do
        expect do
          post "/pools/#{pool.id}/entries"
        end.not_to change(Choice, :count)
      end
    end
  end
end
