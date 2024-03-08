class MembershipsController < ApplicationController
  def destroy
    @membership = Membership.find(params[:id])
    user = @membership.user
    # authorize @membership, :destroy?
    @membership.destroy!
    DestroyUserJob.schedule(user.id) if user.has_no_memberships?

    redirect_to dashboard_path, notice: "Membership removed."
  end
end
