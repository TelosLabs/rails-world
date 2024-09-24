class ProfilePolicy < ApplicationPolicy
  authorize :user, optional: true

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
    return unless user

    record.uuid == user.profile.uuid
  end
end
