module ApplicationHelper
  include Pagy::Frontend

  def render_notice_flash
    notice_message = flash[:notice]
    undo_path = flash[:undo_path]

    return if notice_message.blank?

    render partial: "layouts/flash_message", locals: {message: notice_message, undo_path: undo_path}
  end
end
