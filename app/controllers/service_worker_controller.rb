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
    render "offline", layout: false
  end

  def precache
    session_ids = Session.order(:id).pluck(:id)
    speaker_ids = Speaker.order(:id).pluck(:id)

    pages = [
      root_path,
      schedule_path,
      sessions_path
    ] +
      session_ids.map { |id| session_path(id) } +
      speaker_ids.map { |id| speaker_path(id) }

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

    render json: {
      pages: pages.uniq,
      images: avatars
    }
  end
end
