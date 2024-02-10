class Pools::MembershipsController < ApplicationController
  before_action :load_pool, only: [:new, :create]

  def new
    @membership = @pool.memberships.new
  end

  def create
    @membership = @pool.memberships.new(membership_params)
    if @membership.save
      redirect_to @pool, notice: 'Membership created successfully.'
    else
      render :new
    end
  end

  private

  def load_pool
    @pool = Pool.find(params[:pool_id])
  end

  def membership_params
    user = retrieve_or_create_user
    @membership.errors.add(:email, "must be present") unless user.present?

    params.require(:membership).permit(:role, :active).merge(user_id: user.id)
  end

  def retrieve_or_create_user
    email = params[:membership][:email]
    return unless email.present?
    user = User.find_or_initialize_by(email: email)
    if user.new_record?
      user.password = SecureRandom.hex(8)
      user.save
    end
    user
  end
end
