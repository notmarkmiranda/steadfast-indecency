class PoolsController < ApplicationController
  before_action :set_pool, only: [:show, :edit, :update, :destroy, :invite]

  def index
    @pools = Pool.all
  end

  def show
    if pending_membership.present?
      redirect_to invite_pool_path(@pool, token: pending_membership.invitation_token)
    else
      authorize @pool
      @entries = @pool.entries.where(user: current_user).decorate
      if @pool.editable?
        @question = @pool.questions.build
        @options = 2.times.map { @question.options.build }
      end
    end
  end

  def new
    @pool = Pool.new
  end

  def create
    pcs = PoolCreationService.new(pool_params, current_user.id)

    if pcs.save!
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
    @pool.destroy!
    redirect_to pools_url, notice: "Pool was successfully destroyed."
  end

  def invite
    @membership = GlobalID::Locator.locate_signed(params[:token], for: "membership")
  end

  private

  def set_pool
    @pool = Pool.includes(:entries, memberships: :user, questions: :options).find(params[:id]).decorate
  end

  def pool_params
    params.require(:pool).permit(:name, :description, :cutoff_date, :event_date, :multiple_entries, :price)
  end


  def pending_membership
    @pending_membership ||= Membership.pending.find_by(pool: @pool, user: current_user)
  end
end
