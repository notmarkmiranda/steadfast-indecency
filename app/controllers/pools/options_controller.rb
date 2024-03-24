class Pools::OptionsController < ApplicationController
  def correct
    @pool = Pool.find(params[:pool_id])
    authorize @pool, :admin?
    require 'pry'; binding.pry
    OptionUpdateJob.perform(params[:id])
    # @option = Option.include(question: :options).find(params[:id])
  end
end
