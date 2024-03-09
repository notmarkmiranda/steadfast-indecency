class Pools::MembershipsController < ApplicationController
  before_action :load_pool, only: [:new, :create]

  def new
    authorize @pool, :admin?
    @membership = @pool.memberships.new
  end

  def create
    # TODO: Mark Miranda => refactor this to use a service object
    authorize @pool, :admin?
    @membership = @pool.memberships.new(membership_params)
    @membership.user = retrieve_or_create_user
    if @membership.save
      InviteMailer.with(membership: @membership, new_user: @new_user).invite_new_member.deliver_now
      redirect_to @pool, notice: "Membership created successfully."
    else
      render :new
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    authorize @membership, :destroy?

    # TODO: Mark Miranda => this should be called from a job
    MembershipDeletorService.call(membership_id: @membership.id)

    redirect_to @membership.pool, notice: "Membership removed."
  end

  def accept
    @membership = Membership.find(params[:id])
    @membership.accept!

    redirect_to @membership.pool, notice: "Membership accepted."
  end

  private

  def load_pool
    @pool = Pool.find(params[:pool_id])
  end

  def membership_params
    params.require(:membership).permit(:role, :active)
  end

  def retrieve_or_create_user
    email = params[:membership][:email]
    return if email.blank?
    user = User.find_or_initialize_by(email: email)
    @new_user = user.new_record?
    if @new_user
      user.password = SecureRandom.hex(8)
      user.save!
    end
    user
  end
end
