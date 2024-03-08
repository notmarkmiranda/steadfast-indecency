class MembershipDeletorService
  def self.call(membership_id:)
    new(membership_id: membership_id).call
  end

  def initialize(membership_id:)
    @membership_id = membership_id
  end

  def call
    membership.destroy!

    # TODO: Mark Mirnda => this is a good candidate for a job
    # DestroyUserJob.schedule(user.id) if user.has_no_memberships?
  end

  private

  attr_reader :membership_id

  def membership
    @membership ||= Membership.find(membership_id)
  end
end
