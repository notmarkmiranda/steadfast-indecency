class DashboardController < ApplicationController
  def show
    @pools = current_user.pools
  end
end
