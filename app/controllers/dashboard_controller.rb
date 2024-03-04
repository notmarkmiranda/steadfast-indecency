class DashboardController < ApplicationController
  def show
    @pools = current_user.pools.decorate
  end
end
