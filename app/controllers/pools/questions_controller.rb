class Pools::QuestionsController < ApplicationController
  before_action :load_pool

  def create
    return redirect_to @pool, notice: "This pools is no longer editable" unless @pool.editable?
    @question = @pool.questions.new(question_params)
    authorize @pool, :admin?
    flash = @question.save ? {notice: "Question was successfully created."} : {alert: "Failed to create question."}

    redirect_to @pool, flash
  end

  def edit
    return redirect_to @pool, notice: "This pools is no longer editable" unless @pool.editable?
    @question = @pool.questions.find(params[:id])
    authorize @pool, :edit_prop?
  end

  def update
    @question = Question.find(params[:id])
    authorize @pool, :edit_prop?
    if @question.update(question_params)
      redirect_to @pool, notice: "Question was successfully updated."
    else
      render :edit, alert: "Failed to update question."
    end
  end

  private

  def load_pool
    @pool = Pool.find(params[:pool_id])
  end

  def question_params
    params.require(:question).permit(:body, :tie_break, options_attributes: [:id, :body])
  end
end
