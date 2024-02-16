class DestroyUserJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    user.destroy
  end

  def self.schedule(user_id)
    set(wait: 3.days).perform_later(user_id)
  end
end
