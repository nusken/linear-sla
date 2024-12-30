module SlaRulesHelper
  def render_action_details(form, rule)
    if rule.action_type == "comment"
      form.text_area :action_details, class: "form-control", placeholder: "Enter comment to add"
    elsif rule.action_type == "update_status"
      form.select :action_details, LinearState.pluck(:name, :name), {}, class: "form-control"
    elsif rule.action_type == "update_priority"
      form.select :action_details, Linear::PRIORITY.map { |priority, value| [ priority, value ] }, {}, class: "form-control"
    end
  end

  def filter_type_text(rule)
    case rule.filter_type
    when "priority"
      "Priority"
    when "label"
      "Has Label"
    when "state"
      "Has Status"
    end
  end

  def filter_value_text(rule)
    if rule.filter_type == "priority"
      Linear::PRIORITY.invert[rule.filter_value.to_i]
    else
      rule.filter_value
    end
  end

  def action_details_text(rule)
    if rule.action_type == "update_priority"
      Linear::PRIORITY.invert[rule.action_details.to_i]
    else
      rule.action_details
    end
  end
end
