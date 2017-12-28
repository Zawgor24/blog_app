# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    user_is_owner?
  end

  def edit?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end
end
