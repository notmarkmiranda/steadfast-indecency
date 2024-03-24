class OptionUpdaterService
  def self.call(option_id)
    option = Option.includes(question: :options).find(option_id)
    return unless option
    ActiveRecord::Base.transaction do
      option.correct!
      option.choices.each(&:correct!)
      siblings = option.siblings
      siblings.incorrect!
      siblings.flat_map(&:choices).each(&:incorrect!)
    end
  end
end