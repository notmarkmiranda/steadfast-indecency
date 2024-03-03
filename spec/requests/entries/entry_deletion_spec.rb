require "rails_helper"

RSpec.describe "Entry Deletion", type: :request do
  let(:pool) { create(:pool, :with_questions, question_count: 2, cutoff_date: cutoff_date) }
  let(:membership) { create(:membership, role: 2, pool: pool) }
  let(:admin) { membership.user }

  let(:other_membership) { create(:membership, role: 0, pool: pool) }
  let(:user) { other_membership.user }

  describe "when the cutoff has not passed" do
    let(:cutoff_date) { 1.day.from_now }

    describe "when the user is an admin" do
      before { sign_in(admin) }

      it "deletes the entry" do
        entry = create(:entry, pool: pool, user: user)

        expect do
          delete pool_entry_path(pool, entry)
        end.to change(Entry, :count).by(-1)
      end

      it "deletes the associated choices" do
        ecs = EntryCreationService.new({pool_id: pool.id, user_id: user.id}, pool.questions_count)
        ecs.save!

        expect do
          delete pool_entry_path(pool, ecs.entry)
        end.to change(Choice, :count).by(-pool.questions_count)
      end
    end

    describe "when the user is the entry's owner" do
      before { sign_in(user) }

      it "deletes the entry" do
        entry = create(:entry, pool: pool, user: user)

        expect do
          delete pool_entry_path(pool, entry)
        end.to change(Entry, :count).by(-1)
      end

      it "deletes the associated choices" do
        ecs = EntryCreationService.new({pool_id: pool.id, user_id: user.id}, pool.questions_count)
        ecs.save!

        expect do
          delete pool_entry_path(pool, ecs.entry)
        end.to change(Choice, :count).by(-pool.questions_count)
      end
    end
  end

  describe "when the cutoff has passed" do
    let(:cutoff_date) { DateTime.yesterday }

    describe "when the user is an admin" do
      before { sign_in(admin) }

      it "deletes the entry" do
        entry = create(:entry, pool: pool, user: user)

        expect do
          delete pool_entry_path(pool, entry)
        end.not_to change(Entry, :count)
      end

      it "deletes the associated choices" do
        ecs = EntryCreationService.new({pool_id: pool.id, user_id: user.id}, pool.questions_count)
        ecs.save!

        expect do
          delete pool_entry_path(pool, ecs.entry)
        end.not_to change(Choice, :count)
      end
    end

    describe "when the user is the entry's owner" do
      before { sign_in(user) }

      it "deletes the entry" do
        entry = create(:entry, pool: pool, user: user)

        expect do
          delete pool_entry_path(pool, entry)
        end.not_to change(Entry, :count)
      end

      it "deletes the associated choices" do
        ecs = EntryCreationService.new({pool_id: pool.id, user_id: user.id}, pool.questions_count)
        ecs.save!

        expect do
          delete pool_entry_path(pool, ecs.entry)
        end.not_to change(Choice, :count)
      end
    end
  end
end
