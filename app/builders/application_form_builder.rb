class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper

  STYLES = {
    default: "bg-transparent border border-2 border-white rounded-md text-white
    placeholder-white/50 focus:bg-white focus:text-black focus:placeholder-grey-300
    focus:border-white focus:ring-white transition-all dark:border-gray-600 dark:text-white focus:dark:bg-transparent dark:focus:border-gray-600",
    toggle_field: "relative w-11 h-6 bg-grey-300 rounded-full peer dark:bg-grey-300
    peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full
    peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px]
    after:start-[2px] after:bg-white after:rounded-full after:h-5 after:w-5
    after:transition-all peer-checked:bg-red cursor-pointer",
    error_message: "text-red text-sm",
    label: "font-bold text-base"
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
      options = add_base_styles(options, method_name, attribute)
      super(attribute, options)
    end
  end

  def label(attribute, content_or_options = nil, options = {}, &block)
    options = add_base_styles(options, __method__, attribute)
    super
  end

  def select(attribute, choices = nil, options = {}, html_options = {})
    options = add_base_styles(options, __method__, attribute)
    super
  end

  def error_message(attribute, options = {})
    return unless attribute_has_error?(attribute)

    options = add_base_styles(options, __method__, attribute)
    error_message = @object.errors.full_messages_for(attribute).join(", ")
    content_tag :div, error_message, options
  end

  def toggle_field(attribute, content_or_options = nil, options = {})
    options = add_base_styles(options, __method__, attribute)
    @template.render "shared/form_elements/toggle_field", form: self, attribute: attribute, options: options
  end

  private

  def add_base_styles(options, method_name, attribute)
    return options if options[:skip_base_styling].present?

    style = []
    style << options[:class]
    style << (STYLES[method_name] || STYLES[:default])
    style.join(" ").strip

    options[:class] = style
    options
  end

  def attribute_has_error?(attribute)
    @object&.errors&.map(&:attribute)&.include?(attribute.to_sym)
  end
end
