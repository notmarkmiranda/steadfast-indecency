class Pools::EntriesController < ApplicationController
  before_action :set_pool

  def show
    @entry = Entry.includes(pool: {questions: :options}).find(params[:id])
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
    # authorize @entry
    if @entry.update(entry_params)
      redirect_to pool_entry_path(@pool, @entry), notice: "Entry was successfully updated."
    else
      # render :show
    end
  end

  def destroy
    @entry = Entry.includes(:pool).find(params[:id])
    authorize @entry
    redirect_to @pool, notice: "Entry was successfully destroyed." if @entry.destroy
  end

  def paid
    authorize @pool, :mark_as_paid?
    @entry = Entry.find(params[:id])
    @entry.paid!
    redirect_to @pool, notice: "Entry marked as paid!"
  end

  def unpaid
    authorize @pool, :mark_as_unpaid?
    @entry = Entry.find(params[:id])
    @entry.unpaid!
    redirect_to @pool, notice: "Entry marked as unpaid!"
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
