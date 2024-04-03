require "rails_helper"

RSpec.describe OptionUpdateJob, type: :job do
  include ActiveJob::TestHelper
  let(:option_id) { create(:question, :with_options).options.last.id }

  subject(:job) { described_class.perform_later(option_id) }

  it "queues the job" do
    expect { job }.to have_enqueued_job(described_class).on_queue("default")
  end

  it "is in default queue" do
    expect(described_class.new.queue_name).to eq("default")
  end

  it "executes perform" do
    expect(OptionUpdaterService).to receive(:call).with(option_id)
    perform_enqueued_jobs { job }
  end

  it "queues the job" do
    expect { job }.to have_enqueued_job(described_class)
      .with(option_id)
      .on_queue("default")
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
