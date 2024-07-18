class Avo::BaseResourcesController < Avo::ResourcesController
  include Authentication

  before_action :authenticate_admin_user!
end
