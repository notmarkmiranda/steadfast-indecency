module CorrectHelper
  def correct!
    return unless respond_to? :correct

    update!(correct: true)
  end

  def incorrect!
    return unless respond_to? :correct

    update!(correct: false)
  end
end