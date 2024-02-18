class Pools::EntriesController < ApplicationController
  before_action :set_pool
  
  def show
    @entry = Entry.find(params[:id])
  end

  def new
    @entry = @pool.entries.new
  end

  def create
    @entry = @pool.entries.new(entry_params)

    if @entry.save
      redirect_to pool_entry_path(@pool, @entry), notice: 'Entry was successfully created.'
    else
      # render :new
    end
  end

  private

  def entry_params
    {
      pool_id: @pool.id,
      user_id: current_user.id
    }
  end

  def set_pool
    @pool ||= Pool.find(params[:pool_id])
  end
end
