class Pools::OptionsController < ApplicationController
  def correct
    @pool = Pool.find(params[:id])
    authorize @pool, :admin?
    OptionUpdateJob.perform_now(params[:option_id])
    redirect_to admin_pool_path(@pool)
  end
end
