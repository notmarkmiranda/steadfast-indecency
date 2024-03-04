class PoolDecorator < Draper::Decorator
  delegate_all

  def cutoff_date_time
    object.cutoff_date.in_time_zone("America/Denver").strftime("%B %d, %Y - %l:%M %p")
  end

  def event_date_time
    object.event_date.in_time_zone("America/Denver").strftime("%B %d, %Y - %l:%M %p")
  end

  def entry_button
    disabled = pool.entry_ineligible?(h.current_user)
    css_classes = if disabled
      "text-white font-medium disabled:bg-indigo-100 px-4 py-2 rounded-md"
    else
      "text-white font-medium bg-indigo-600 px-4 py-2 rounded-md"
    end
    h.button_to "Create Entry", h.pool_entries_path(pool), disabled: disabled, class: css_classes
  end

  def multiple_entries_text
    object.allows_multiple_entries? ? "Yes" : "No"
  end

  def superadmin_email
    superadmin&.email || "🤷🏻‍♂️ No Superadmin"
  end
end
