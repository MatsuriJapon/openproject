require_relative './work_package_field'

class WorkPackageTextAreaField < WorkPackageField

  attr_reader :trigger

  def initialize(context, property_name, selector: nil, trigger: nil)
    super(context, property_name, selector: selector)
    @trigger = trigger
  end

  def trigger_link_selector
    @trigger || super
  end

  def input_selector
    'textarea'
  end

  def expect_save_button(enabled: true)
    if enabled
      expect(element).to have_no_selector("#{control_link}[disabled]")
    else
      expect(element).to have_selector("#{control_link}[disabled]")
    end
  end

  def save!
    submit_by_click
  end

  def submit_by_click
    target = element.find(control_link)
    scroll_to_element(target)
    target.click
  end

  def submit_by_keyboard
    input_element.native.send_keys :tab
  end

  def cancel_by_click
    target = element.find(control_link(:cancel))
    scroll_to_element(target)
    target.click
  end

  def field_type
    'textarea'
  end

  def control_link(action = :save)
    raise 'Invalid link' unless [:save, :cancel].include?(action)
    ".inplace-edit--control--#{action}"
  end
end
