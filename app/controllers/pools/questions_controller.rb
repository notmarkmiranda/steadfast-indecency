class Pools::QuestionsController < ApplicationController
  before_action :load_pool

  def create
    @question = @pool.questions.new(question_params)
    flash = @question.save ? { notice: 'Question was successfully created.' } : { alert: 'Failed to create question.' }

    redirect_to @pool, flash
  end

  private

  def load_pool
    @pool = Pool.find(params[:pool_id])
  end

  def question_params
    params.require(:question).permit(:body, :tie_break, options_attributes: [:body])
  end
end
