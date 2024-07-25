class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper

  DEFAULT_TYPES = [:text_field, :password_field, :email_field, :number_field, :date_field,
    :text_area, :radio_button, :search_field].freeze

  STYLES_MAP = {
    text_field: "text-white placeholder-white transition-all bg-transparent border-2 border-white rounded-md focus:bg-white focus:text-black focus:placeholder-gray focus:border-white focus:ring-white",
    label: "text-slate-600 text-sm font-medium",
    select_field: "form-builder-select-field",
    submit_field: "form-builder-submit",
    check_box: "form-builder-check-box",
    toggle_switch: "form-builder-toggle-switch",
    full_errors: "form-builder-full-errors",
    pill: "form-builder-pill",
    default: ""
  }.freeze

  ERROR_STYLES_MAP = {
    default: "ring-1 ring-red-500 !focus:ring-red-500"
  }.freeze

  def label(attribute, content_or_options = nil, options = {}, &block)
    super(attribute, content_or_options, add_style(options, __method__, attribute), &block)
  end

  def text_field(attribute, options = {})
    super(attribute, add_style(options, __method__, attribute))
  end

  def check_box(attribute, options = {}, legacy: false)
    if legacy
      super attribute, options
    else
      super(attribute, add_style(options, __method__, attribute))
    end
  end

  def date_field(attribute, options = {})
    super(attribute, add_style(options, __method__, attribute))
  end

  def number_field(attribute, options = {})
    super(attribute, add_style(options, __method__, attribute))
  end

  def email_field(attribute, options = {})
    super(attribute, add_style(options, __method__, attribute))
  end

  def search_field(attribute, options = {})
    super(attribute, add_style(options, __method__, attribute))
  end

  def password_field(attribute, options = {})
    super(attribute, add_style(options, __method__, attribute))
  end

  def select(attribute, choices = nil, options = {}, html_options = {})
    super(attribute, choices, add_style(options, __method__, attribute))
  end

  def text_area(attribute, options = {})
    super(attribute, add_style(options, __method__, attribute))
  end

  # New elements
  def full_errors(attribute, options = {})
    return unless attribute_has_error?(attribute)

    content_tag :div, full_message_errors(attribute), add_style(options, __method__, attribute)
  end

  def toggle_switch(attribute, options = {})
    check_box(attribute, add_style(options, __method__, attribute), legacy: true)
  end

  def pill(attribute, content_or_options = nil, options = {}, &block)
    label(attribute, content_or_options, add_style(options, __method__, attribute), &block)
  end


  private

  def add_style(options, method, attribute)
    options[:class] = "#{options[:class]} #{input_style_by_type(method)} #{error_styles(method, attribute)}".strip
    options
  end

  def full_message_errors(attribute)
    @object.errors.full_messages_for(attribute).join(", ")
  end

  def error_styles(type, attribute)
    return nil unless attribute_has_error?(attribute).present?

    ERROR_STYLES_MAP[type] || DEFAULT_TYPES.include?(type) && ERROR_STYLES_MAP[:default]
  end

  def input_style_by_type(type)
    STYLES_MAP[type] || DEFAULT_TYPES.include?(type) && STYLES_MAP[:default]
  end

  def attribute_has_error?(attribute)
    @object&.errors&.include?(attribute.to_sym)
  end
end