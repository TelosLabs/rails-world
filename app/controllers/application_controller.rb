class ApplicationController < ActionController::Base
  include Authentication
  default_form_builder ApplicationFormBuilder
end
