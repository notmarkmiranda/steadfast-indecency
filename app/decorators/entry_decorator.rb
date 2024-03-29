class EntryDecorator < Draper::Decorator
  delegate_all

  def pool_show_link(index, enabled: true)
    h.link_to_if enabled, "Entry ##{index + 1}", h.pool_entry_path(object.pool, object)
  end

  def delete_button
    h.content_tag :div, class: "text-lg text-red-600" do
      h.button_to h.pool_entry_path(object.pool, object), method: :delete, form: {data: {turbo_confirm: "Are you sure? \n 🚨 This cannot be undone. 🚨"}} do
        h.content_tag :i, nil, class: "fa-regular fa-circle-xmark"
      end
    end
  end

  def paid_unpaid_button
    if object.paid
      h.button_to h.unpaid_pool_entry_path(object.pool, object), class: "px-2 py-1 text-white bg-red-500 border-red-500 rounded-lg hover:bg-red-600" do
        "Mark as Unpaid"
      end
    else
      h.button_to h.paid_pool_entry_path(object.pool, object), class: "px-2 py-1 text-white bg-green-500 border-green-500 rounded-lg hover:bg-green-600" do
        "Mark as Paid"
      end
    end
  end

  def paid_icon
    if object.paid
      h.content_tag :i, nil, class: "fa-solid fa-star text-green-500"
    else
      h.content_tag :span, class: "text-yellow-500" do
        h.content_tag :i, nil, class: "fa-solid fa-circle-xmark"
      end
    end
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
