class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper
  # include CustomTheme

  STYLES_MAP = {
    full_errors: "text-white text-xs",
    default: "text-white placeholder-white transition-all bg-transparent border-2 border-white
    rounded-md focus:bg-white focus:text-black focus:placeholder-gray focus:border-white focus:ring-white"
  }.freeze

  ERROR_STYLES_MAP = {
    default: "ring-1 ring-red-500 !focus:ring-red-500"
  }.freeze

  [
    :text_field,
    :check_box,
    :date_field,
    :email_field,
    :number_field,
    :search_field,
    :password_field,
    :text_area
  ].each do |method_name|
    define_method(method_name) do |attribute, options = {}|
      options = process_styles(options, method_name, attribute)
      super(attribute, options)
    end
  end

  def label(attribute, content_or_options = nil, options = {}, &block)
    options = process_styles(options, __method__, attribute)
    super
  end

  def select(attribute, choices = nil, options = {}, html_options = {})
    options = process_styles(options, __method__, attribute)
    super
  end

  # New elements
  def full_errors(attribute, options = {})
    return unless attribute_has_error?(attribute)

    options = process_styles(options, __method__, attribute)
    content_tag :div, full_message_errors(attribute), options
  end

  private

  def process_styles(options, method_name, attribute)
    options[:class] = styles(options, method_name, attribute) if options[:legacy].blank?
    options.except(:legacy)
  end

  def styles(options, method, attribute)
    style = []
    style << options[:class]
    style << (STYLES_MAP[method] || STYLES_MAP[:default])
    style << (ERROR_STYLES_MAP[method] || ERROR_STYLES_MAP[:default]) if attribute_has_error?(attribute)
    style.join(" ").strip
  end

  def attribute_has_error?(attribute)
    @object&.errors&.include?(attribute.to_sym)
  end

  def full_message_errors(attribute)
    @object.errors.full_messages_for(attribute).join(", ")
  end
end
