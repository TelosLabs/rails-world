class ProfilePolicy < ApplicationPolicy
  def show?
    owner? || record.is_public
  end

  def edit?
    owner?
  end

  def update?
    edit?
  end

  private

  def owner?
    record.uuid == user.profile.uuid
  end
end
