class MembershipDecorator < Draper::Decorator
  delegate_all

  def role_text
    role.humanize
  end

  def entered_text
    object.pool.entries.where(user: object.user).any? ? "Yes" : "No"
  end
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
end
