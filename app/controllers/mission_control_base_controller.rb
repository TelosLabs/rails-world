class MissionControlBaseController < ApplicationController
  before_action { authorize! current_user, with: MissionControlPolicy, to: :show? }
end
