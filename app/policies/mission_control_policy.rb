class MissionControlPolicy < ApplicationPolicy
  def show?
    user.admin?
  end
end
