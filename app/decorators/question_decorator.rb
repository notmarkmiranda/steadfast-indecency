class QuestionDecorator < Draper::Decorator
  delegate_all

  def correct_option_a_or_b
    if has_correct_option?
      (correct_option == first_option) ? "A" : "B"
    end
  end

  def choice_option_a_or_b(entry)
    option = entry.choice_for_question(self).option
    (option == first_option) ? "A" : "B"
  end

  def first_option_body
    first_option.body
  end

  def last_option_body
    last_option.body
  end

  def option_choice_css(entry)
    css = "border border-gray-200 px-4 py-2 text-center"
    choice = entry.choice_for_question(self)
    if choice&.correct == true
      css += " bg-green-500"
    elsif choice&.correct == false
      css += " bg-red-500"
    end
    css
  end

  def first_option_css
    if first_option_correct?
      "w-full hover:text-white text-white border border-blue-700 bg-gray-700 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium text-sm px-2 py-1 text-center me-2 mb-2"
    else
      "w-full text-blue-700 hover:text-white border border-blue-700 hover:bg-gray-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium text-sm px-2 py-1 text-center me-2 mb-2 dark:border-blue-500 dark:text-blue-500 dark:hover:text-white dark:hover:bg-gray-500 dark:focus:ring-blue-800"
    end
  end

  def last_option_css
    if last_option_correct?
      "w-full hover:text-red-700 text-white border border-red-700 bg-gray-600 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium text-sm px-2 py-1 text-center me-2 mb-2"
    else
      "w-full text-red-800 hover:text-white border border-red-700 hover:bg-gray-800 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium text-sm px-2 py-1 text-center me-2 mb-2"
    end
  end

  def first_option_correct?
    first_option.correct?
  end

  def last_option_correct?
    last_option.correct?
  end
end
