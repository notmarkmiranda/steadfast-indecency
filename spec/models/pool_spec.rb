# == Schema Information
#
# Table name: pools
#
#  id               :bigint           not null, primary key
#  cutoff_date      :datetime
#  description      :string
#  event_date       :datetime
#  multiple_entries :boolean          default(FALSE)
#  name             :string           not null
#  price            :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require "rails_helper"

RSpec.describe Pool, type: :model do
  it { should have_many :memberships }
  it { should have_many(:users).through(:memberships) }
  it { should have_many :questions }
  it { should have_many :entries }

  describe "users for scoreboard sorting" do
    describe "#users_by_points" do
      let(:pool) { create(:pool, :with_questions, question_count: 3) }

      before do
        entries = create_list(:entry, 3, pool: pool)
        questions = pool.questions
        entries.each do |entry|
          questions.each do |question|
            create(:choice, entry: entry, question: question, option: question.options.sample)
          end
        end

        first = entries[0]
        first.choices.each do |choice|
          choice.update(correct: true)
        end

        second = entries[1]
        second.choices[2].update!(correct: false)
        second.choices[0..1].each do |choice|
          choice.update!(correct: true)
        end

        third = entries[2]
        third.choices.each do |choice|
          choice.update!(correct: false)
        end

        @users = [first.user, second.user, third.user]
        @users.each do |user|
          create(:membership, pool: pool, user: user, role: 0, active: true)
        end
      end

      it "returns users by points" do
        expect(pool.users_by_points).to eq(@users)
      end
    end

    describe "#users_by_possible_points" do
      it "returns users by possible points"
    end
  end
end
