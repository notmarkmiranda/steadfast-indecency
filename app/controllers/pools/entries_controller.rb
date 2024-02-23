class Pools::EntriesController < ApplicationController
  before_action :set_pool

  def show
    @entry = Entry.includes(pool: {questions: :options}).find(params[:id])
    @choices = @entry.choices.build
  end

  def new
    @entry = @pool.entries.new
  end

  def create
    authorize @pool, :create_entry?
    @ecs = EntryCreationService.new(entry_creation_params, @pool.questions_count)
    if @ecs.save
      redirect_to pool_entry_path(@pool, @ecs.entry), notice: "Entry was successfully created."
    else
      # render :new
    end
  end

  def update
    @entry = Entry.find(params[:id])
    if @entry.update(entry_params)
      redirect_to pool_entry_path(@pool, @entry), notice: "Entry was successfully updated."
    else
      # render :show
    end
  end

  private

  def entry_creation_params
    {
      pool_id: @pool.id,
      user_id: current_user.id
    }
  end

  def entry_params
    params.require(:entry).permit(:id, choices_attributes: [:id, :option_id])
  end

  def set_pool
    @pool ||= Pool.find(params[:pool_id])
  end
end
