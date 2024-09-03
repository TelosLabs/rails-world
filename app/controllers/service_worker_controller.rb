class ServiceWorkerController < ApplicationController
  allow_unauthenticated_access

  protect_from_forgery except: :service_worker

  def service_worker
  end

  def manifest
  end

  def offline
  end
end
