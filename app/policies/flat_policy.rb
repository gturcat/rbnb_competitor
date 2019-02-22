class FlatPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def list?
    true
  end
  def new?
    record.user == user
  end

  def create?
    # record.user == user
    true
  end

  def edit?
    record.user == user
  end

  def update?
    record.user == user
    # - record: the flat passed to the `authorize` method in controller
    # - user:   the `current_user` signed in with Devise.
  end

  def destroy?
    record.user == user
  end
end
