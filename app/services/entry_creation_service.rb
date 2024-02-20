class EntryCreationService
  attr_reader :entry, :questions_count

  def initialize(params, questions_count)
    @params = params
    @questions_count = questions_count
  end

  def save
    @entry = Entry.create(@params)
    question_ids = @entry.pool.questions.pluck(:id)
    entry_id = @entry.id
    choices_params = question_ids.map do |question_id|
      {
        question_id:,
        entry_id:
      }
    end
    @choices = Choice.create(choices_params)

    return true if @entry.valid? && @choices.all?(&:valid?)

    false
  end
end