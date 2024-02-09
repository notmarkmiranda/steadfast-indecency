class PoolsController < ApplicationController
  before_action :set_pool, only: [:show, :edit, :update, :destroy]

  def index
    @pools = Pool.all
  end

  def show
  end

  def new
    @pool = Pool.new
  end

  def create
    pcs = PoolCreationService.new(pool_params, current_user.id)

    if pcs.save
      redirect_to pcs.pool, notice: "Pool was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @pool.update(pool_params)
      redirect_to @pool, notice: "Pool was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @pool.destroy
    redirect_to pools_url, notice: "Pool was successfully destroyed."
  end

  private

  def set_pool
    @pool = Pool.find(params[:id])
  end

  def pool_params
    params.require(:pool).permit(:name, :description, :cutoff_date, :event_date, :multiple_entries)
  end
end