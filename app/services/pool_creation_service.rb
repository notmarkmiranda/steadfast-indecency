class PoolCreationService
  attr_reader :pool, :user_id

  def initialize(pool_params, user_id)
    @pool = Pool.new(pool_params)
    @user_id = user_id
  end

  def save
    pool.save && pool.create_super_admin(user_id)
  end
end
