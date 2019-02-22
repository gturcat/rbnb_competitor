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
    true
  end

  def create?
    true
  end

  def edit?
    true
  end

  def update?
    true
    # - record: the flat passed to the `authorize` method in controller
    # - user:   the `current_user` signed in with Devise.
  end

  def destroy?
    true
  end
end
