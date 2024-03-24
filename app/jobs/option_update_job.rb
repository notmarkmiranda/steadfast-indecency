class OptionUpdateJob < ApplicationJob
  queue_as :default

  def perform(option_id)
    OptionUpdaterService.call(option_id)
  end
end