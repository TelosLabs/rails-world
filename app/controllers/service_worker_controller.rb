class ServiceWorkerController < ApplicationController
  allow_unauthenticated_access

  protect_from_forgery except: :service_worker

  def service_worker
    response.headers["Service-Worker-Allowed"] = "/"
    render "service_worker", formats: :js, content_type: "application/javascript"
  end

  def manifest
    render "manifest", formats: :json, content_type: "application/manifest+json"
  end

  def offline
    render "offline"
  end

  def precache
    session_rows = Session.order(:id).pluck(:id, :slug)
    session_pages = session_rows.map do |id, slug|
      session_path(slug.presence || id)
    end

    speaker_rows = Speaker.order(:id).pluck(:id, :slug)
    speaker_pages = speaker_rows.map do |id, slug|
      speaker_path(slug.presence || id)
    end

    date_pages =
    Array(Current.conference&.dates).map do |date|
      sessions_path(starts_at: date)
    end

    pages = [
      root_path,
      schedule_path,
      sessions_path,
      profile_root_path,
      notifications_path,
      about_path,
      privacy_policy_path,
      account_deletion_path,
      coming_soon_path,
      notification_settings_path
    ] + session_pages + speaker_pages + date_pages.uniq

    avatars = []
    if Speaker.method_defined?(:avatar)
      speakers = Speaker.with_attached_avatar
      avatars = speakers.filter_map do |s|
        next unless s.avatar.attached?
        rails_representation_path(
          s.avatar.variant(resize_to_fill: [128, 128]).processed,
          only_path: true
        )
      end.uniq
    end


    Rails.logger.info "[SW precache] Dates: #{Current.conference&.dates.inspect}"
    Rails.logger.info "[SW precache] Pages count=#{pages.size}"
    pages.each { |p| Rails.logger.info "[SW precache] #{p}" }


    render json: {pages: pages.uniq, images: avatars}
  end
end
